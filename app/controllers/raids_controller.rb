class RaidsController < ApplicationController

  requires_user
  requires_permission :schedule_raid, :only => [:new, :create, :edit, :update]
  navigation :raids

  def index
    @raids = ListRaids.for_guild current_guild
  end

  def show
    @raid = find_raid params[:id]
    @signups = ListSignups.for_raid(@raid)

    @current_user_characters = ListCharacters.new(current_user).run

    # Possibly move this logic elsewhere? Feels too much like implementation
    # details in the controller.
    choosable_characters = @current_user_characters.reject do |character|
      @signups.contains? character
    end

    @choosable_characters_by_guild = CharactersByGuild.new(choosable_characters)
  end

  def new
    @raid = Raid.new
  end

  def create
    schedule_raid
    redirect_to raids_path
  end

  def edit
    @raid = find_raid params[:id]

    unless @raid
      redirect_to action: "index"
    end
  end

  def update
    @raid = find_raid params[:id]
    schedule_raid @raid

    redirect_to raids_path
  end

  protected

  def permission_denied_path
    raids_path
  end

  def find_raid(id)
    FindRaid.by_id id.to_i
  end

  def schedule_raid(raid = nil)
    action = ScheduleRaid.new current_guild
    action.current_raid = raid

    raid_attrs = params[:raid]

    action_params = [
      raid_attrs[:where], Date.parse(raid_attrs[:when]), Time.parse(raid_attrs[:start_at])
    ]

    if raid_attrs[:tank]
      action_params << {
        :tank => raid_attrs[:tank].to_i,
        :dps => raid_attrs[:dps].to_i,
        :healer => raid_attrs[:healer].to_i
      }
    end

    action.run(*action_params)
  end

end

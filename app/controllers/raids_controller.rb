class RaidsController < ApplicationController

  requires_user

  def index
    @raids = ListRaids.for_guild current_guild
  end

  def show
    @raid = find_raid params[:id]
    @signups = ListSignups.new.for_raid(@raid)

    @current_user_characters = ListCharacters.new(current_user).run
    @choosable_characters = @current_user_characters.reject do |character|
      @signups.contains? character
    end
  end

  def new
    # NOTE Hmm, direct access to domain model here...
    # At the same time this is only for presenting the form to the user
    # so it's not really app-specific logic.
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

  def find_raid(id)
    FindRaid.by_id id.to_i
  end

  def schedule_raid(raid = nil)
    action = ScheduleRaid.new current_user
    action.current_raid = raid

    action_params = [
      params[:where], Date.parse(params[:when]), Time.parse(params[:start])
    ]

    if params[:tank]
      action_params << {
        :tank => params[:tank].to_i,
        :dps => params[:dps].to_i,
        :heal => params[:heal].to_i
      }
    end

    action.run(*action_params)
  end

end

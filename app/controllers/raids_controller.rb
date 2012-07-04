class RaidsController < ApplicationController

  requires_user

  def index
    action = ListRaids.new current_user
    @raids = action.run
  end

  def show
    @current_user_characters = ListCharacters.new(current_user).run
    @raid = find_raid params[:id]
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
    redirect_to action: "index" unless @raid
  end

  def update
    @raid = find_raid params[:id]
    schedule_raid @raid

    redirect_to raids_path
  end

  protected

  def find_raid(id)
    ShowRaid.new.by_id id.to_i
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

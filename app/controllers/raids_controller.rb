class RaidsController < ApplicationController

  requires_user

  def index
    action = FindRaidsForUser.new current_user
    @raids = action.run
  end

  def new
    # NOTE Hmm, direct access to domain model here...
    # At the same time this is only for presenting the form to the user
    # so it's not really app-specific logic.
    @raid = Raid.new
  end

  def create
    action = ScheduleRaid.new current_user

    action_params = [
      params[:where], Date.parse(params[:when]), Time.parse(params[:start])
    ]

    if params[:tank]
      action_params << {
        :tank => params[:tank].to_i,
        :dps => params[:dps].to_i,
        :healer => params[:healer].to_i
      }
    end

    action.run(*action_params)
    redirect_to action: "index"
  end

end

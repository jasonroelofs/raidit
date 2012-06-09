class RaidsController < ApplicationController

  requires_user

  def index
    action = FindRaidsForUser.new current_user
    @raids = action.run
  end

  def new
  end

  def create
    action = ScheduleRaid.new current_user
    action.run params[:where], Date.parse(params[:when]), Time.parse(params[:start])
    redirect_to action: "index"
  end

end

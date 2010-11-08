class RaidsController < ApplicationController

  # Make a new raid. 
  # Can take a :date and will default the raid to be
  # starting on that date. Otherwise will choose today
  def new
    date = params[:date] ? Date.parse(params[:date]) : Date.today
    @raid = Raid.new(:date => date)
  end

  # Create a new raid for the current guild
  def create
    current_guild.raids.create(params[:raid])
    redirect_to(root_path)
  end

end

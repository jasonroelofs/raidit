class RaidsController < ApplicationController

  # Make a new raid. 
  # Can take a :date and will default the raid to be
  # starting on that date. Otherwise will choose today
  def new
    date = params[:date] ? Date.parse(params[:date]) : Date.today
    @raid = Raid.new(
      :date => date,
      :invite_time => Time.zone.parse("7:45 pm"),
      :start_time => Time.zone.parse("8:00 pm")
    )
  end

  # Look at the details of a selected raid.
  # Includes ability to queue for raid, approve / deny people
  # etc.
  def show
    @raid = current_guild.raids.find(params[:id])
    @main = current_user.main_character
    @characters = current_user.characters
  end

  # Create a new raid for the current guild
  def create
    current_guild.raids.create(params[:raid])
    redirect_to(root_path)
  end

  # Add a character as 'queued' to this raid
  def enqueue
    raid = current_guild.raids.find(params[:id])
    raid.queued.add!(
      current_user.characters.find(params[:character_id]),
      params[:role]
    )

    redirect_to(raid_path(raid))
  end

end

class RaidsController < ApplicationController

  before_filter :authenticate_user!, :except => [:show]

  requires_permission :raid_leader, :except => [:show]

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

  # Edit an existing raid
  def edit
    @raid = current_guild.raids.find(params[:id])
  end

  # Update an existing raid
  def update
    raid = current_guild.raids.find(params[:id])
    raid.update_attributes(params[:raid])
    redirect_to(raid_path(raid))
  end

  # Update a character queueing for the given raid
  def update_queue
    char = current_guild.characters.find(params[:character])
    raid = current_guild.raids.find(params[:id])
    action = params[:do]
    role = params[:role]

    QueueManager.process(action, raid, role, char)

    redirect_to(raid_path(raid))
  end

  # Look at the details of a selected raid.
  # Includes ability to queue for raid, approve / deny people
  # etc.
  def show
    @raid = current_guild.raids.find(params[:id])

    if current_user
      @main = current_user.main_character
      @characters = current_user.characters
    end
  end

  # Create a new raid for the current guild
  def create
    current_guild.raids.create(params[:raid])
    redirect_to(root_path)
  end

  # Add a character as 'queued' to this raid
  def enqueue
    raid = current_guild.raids.find(params[:id])

    if raid.upcoming?
      raid.queued.add!(
        current_user.characters.find(params[:character_id]),
        params[:role]
      )
    end

    redirect_to(raid_path(raid))
  end

end

class RaidsController < ApplicationController

  before_filter :authenticate_user!, :except => [:show]

  requires_permission :raid_leader, :except => [:show, :enqueue, :update_queue]

  respond_to :html, :js

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

    respond_to do |wants|
      wants.html {
        redirect_to(raid_path(raid))
      }
      wants.js {
        render :text => results_string(action)
      }
    end
  end

  # Look at the details of a selected raid.
  # Includes ability to queue for raid, approve / deny people
  # etc.
  def show
    @raid = current_guild.raids.find(params[:id])

    if current_user && current_user.characters.any?
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

  protected

  def results_string(action)
    case action
    when "accept"
      "Accepted"
    when "queue"
      "Queued"
    when "cancel"
      "Cancelled"
    end
  end

end

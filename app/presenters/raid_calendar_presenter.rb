require 'ostruct'
require 'interactors/list_raids'

class RaidCalendarPresenter

  attr_accessor :start_date, :weeks_to_show

  def initialize(current_guild)
    @current_guild = current_guild

    @start_date = Date.today
    @weeks_to_show = 4
  end

  ##
  # Return an Enumerable of Week objects built up according to
  # the values given in the constructor
  ##
  def weeks
    return @weeks if @weeks

    @weeks = []
    @weeks_to_show.times do |i|
      root = i.weeks.from_now(@start_date)
      @weeks << Week.new(
        root.beginning_of_week(:sunday).to_date,
        root.end_of_week(:sunday).to_date
      )
    end

    @weeks
  end

  ##
  # Return an Enumerable of days that the given week contains
  ##
  def days_for_week(week)
    (week.start_date..week.end_date).to_a
  end

  ##
  # Figure out the appropriate class for the cell day we are
  # currently rendering.
  ##
  def class_for(day)
    if day == @start_date
      "today"
    elsif day < @start_date
      "past"
    end
  end

  ##
  # Find all raids to be shown for the given day.
  # Returns an Enumerable of Raid objects
  ##
  def raids_on(date)
    ListRaids.for_guild_on_date(@current_guild, date)
  end

  ##
  # Returns the following status symbols if the current user has
  # a signup in the given raid
  ##
  def signup_status_for(user, raid)
    statuses = ListSignups.for_raid_and_user(raid, user).map &:acceptance_status

    if statuses.include?(:accepted)
      :accepted
    elsif statuses.include?(:available)
      :available
    elsif statuses.include?(:cancelled)
      :cancelled
    else
      ""
    end
  end

  # Represent a given week in the raid calendar
  class Week < Struct.new(:start_date, :end_date)
  end
end

require 'ostruct'

class RaidCalendarPresenter

  attr_accessor :start_date, :weeks_to_show

  attr_reader :raid_finder

  ##
  # Set up a new presenter with a raid finder object.
  # This object needs to respond to #run(date) and return the list of
  # raids that should be displayed for that date.
  #
  # Defaults start_date to today and weeks_to_show to 4
  ##
  def initialize(raid_finder)
    @raid_finder = raid_finder

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
  def raids_on(day)
    []
  end

  # Represent a given week in the raid calendar
  class Week < Struct.new(:start_date, :end_date)
  end
end
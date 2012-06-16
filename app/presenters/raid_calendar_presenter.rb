require 'ostruct'

class RaidCalendarPresenter

  attr_reader :start_date, :weeks_to_show

  ##
  # Set up a new presenter with a date in the first week to show, and configure
  # how many weeks the presenter should show.
  ##
  def initialize(start_date, weeks_to_show = 4)
    @start_date = start_date
    @weeks_to_show = weeks_to_show
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
  # Figure out the apporpriate class for the cell day we are
  # currently rendering.
  ##
  def class_for(day)
    if day == @start_date
      "today"
    elsif day < @start_date
      "past"
    end
  end

  # Represent a given week in the raid calendar
  class Week < Struct.new(:start_date, :end_date)
  end
end
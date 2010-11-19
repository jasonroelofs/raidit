class CalendarCell < Cell::Rails

  class Day
    attr_accessor :date, :day_number, :date_class
  end

  # Render the table
  def show
    render
  end

  # Render a single week. Requires week offset from
  # "this" week
  def week
    which = @opts[:which]
    this_sunday = Date.today.beginning_of_week
    week_sunday = this_sunday + which.weeks

    @days = []

    week_sunday.upto(week_sunday.end_of_week).each do |date|
      d = Day.new
      d.date = date

      # Mark new month boundaries
      if date.day == 1
        d.day_number = date.to_s(:short)
      else
        d.day_number = date.to_s(:day)
      end

      d.date_class = get_date_class_for(date)

      @days << d
    end

    render
  end

  # Render links for each of the raids for the given day
  def raids
    date = @opts[:date]

    @raids = Guild.current.raids.for(date).all

    if @raids.any?
      render
    end
  end

  protected

  def get_date_class_for(date)
    if date == Date.today
      "today"
    elsif date < Date.today
      "past"
    else
      nil
    end
  end

end

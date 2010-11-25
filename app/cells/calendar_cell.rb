class CalendarCell < Cell::Rails

  # Render links for each of the raids for the given day
  def raids
    date = @opts[:date]

    @raids = Guild.current.raids.for(date).all

    if @raids.any?
      render
    end
  end

end

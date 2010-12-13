class CalendarController < ApplicationController

  # Default view of the calendar
  # This is the main landing page for anyone
  # visiting the tool.
  def show
    if current_user.characters.empty?
      flash[:warning] = "You don't have any characters assigned. Click 'My Characters' above to do so."
    end
  end

end

class HomeController < ApplicationController

  def index
    @raid_calendar_presenter = RaidCalendarPresenter.new(
      FindRaidsForUser.new(current_user)
    )
  end

end

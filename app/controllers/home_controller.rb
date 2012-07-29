class HomeController < ApplicationController

  def index
    @raid_calendar_presenter = RaidCalendarPresenter.new(
      current_guild
    )
  end

end

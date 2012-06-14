class HomeController < ApplicationController

  def index
    @raid_calendar_presenter = RaidCalendarPresenter.new Date.today, 4
  end

end

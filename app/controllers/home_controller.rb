class HomeController < ApplicationController

  navigation :home

  def index
    @raid_calendar_presenter = RaidCalendarPresenter.new(
      current_guild
    )
  end

end

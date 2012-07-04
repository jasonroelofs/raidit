class HomeController < ApplicationController

  def index
    @raid_calendar_presenter = RaidCalendarPresenter.new(
      ListRaids.new(current_user)
    )
  end

end

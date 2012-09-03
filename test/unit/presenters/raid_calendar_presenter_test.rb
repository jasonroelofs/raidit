require 'unit/test_helper'
require 'presenters/raid_calendar_presenter'
require 'models/user'
require 'models/raid'
require 'models/guild'
require 'models/signup'
require 'interactors/list_signups'

describe RaidCalendarPresenter do

  it "defaults start_date to today" do
    p = RaidCalendarPresenter.new nil
    p.start_date.must_equal Date.today
  end

  it "defaults weeks to show to 4" do
    p = RaidCalendarPresenter.new nil
    p.weeks_to_show.must_equal 4
  end

  it "allows changing the start date" do
    p = RaidCalendarPresenter.new nil
    p.start_date = Date.parse("2012/01/01")
    p.start_date.must_equal Date.parse("2012/01/01")
  end

  it "allows changing the number of weeks to show" do
    p = RaidCalendarPresenter.new nil
    p.weeks_to_show = 10
    p.weeks_to_show.must_equal 10
  end

  describe "#weeks" do
    before do
      @presenter = RaidCalendarPresenter.new nil
      @presenter.start_date = Date.parse("2012/06/13")
      @presenter.weeks_to_show = 2
    end

    it "returns list of weeks requested of it" do
      @presenter.weeks.length.must_equal 2
    end

    it "builds weeks that start on Sunday and end on Saturday" do
      week1, week2 = @presenter.weeks

      week1.start_date.must_equal Date.parse("2012/06/10")
      week1.end_date.must_equal Date.parse("2012/06/16")

      week2.start_date.must_equal Date.parse("2012/06/17")
      week2.end_date.must_equal Date.parse("2012/06/23")
    end
  end

  describe "#days_for_week" do
    before do
      @presenter = RaidCalendarPresenter.new nil
      @presenter.start_date = Date.parse("2012/06/13")
    end

    it "returns list of days in the given week" do
      week = @presenter.weeks.first
      @presenter.days_for_week(week).length.must_equal 7
    end
  end

  describe "#class_for" do
    before do
      @presenter = RaidCalendarPresenter.new nil
      @presenter.start_date = Date.parse("2012/06/13")
    end

    it "returns 'past' if the day is in the past" do
      @presenter.class_for(Date.parse("2012/06/12")).must_equal "past"
    end

    it "returns 'today' if the day is the given start date" do
      @presenter.class_for(Date.parse("2012/06/13")).must_equal "today"
    end

    it "returns nothing if the day is in the future" do
      @presenter.class_for(Date.parse("2012/06/14")).must_be_nil
    end
  end

  describe "#raids_on" do
    before do
      @guild = Guild.new

      @presenter = RaidCalendarPresenter.new @guild
      @presenter.start_date = Date.parse("2012/07/01")
    end

    it "returns the list of raids viewable to the user on the given day" do
      ListRaids.expects(:for_guild_on_date).with(@guild, Date.parse("2012/07/01")).returns(
        [
          r1 = Raid.new(:when => Date.parse("2012/07/01")),
          r2 = Raid.new(:when => Date.parse("2012/07/01"))
        ]
      )

      @presenter.raids_on(Date.parse("2012/07/01")).must_equal [r1, r2]
    end
  end

  describe "#my_signup_status_for" do
    before do
      @raid = Raid.new
      @user = User.new
      @guild = Guild.new
      @presenter = RaidCalendarPresenter.new @guild
      @presenter.start_date = Date.parse("2012/07/01")
    end

    it "returns :accepted if current user has an accepted character" do
      signup = Signup.new
      signup.acceptance_status = :accepted

      ListSignups.expects(:for_raid_and_user).with(@raid, @user).returns([signup])

      @presenter.signup_status_for(@user, @raid).must_equal :accepted
    end

    it "returns :available if current user has a queued character" do
      signup = Signup.new
      signup.acceptance_status = :available

      ListSignups.expects(:for_raid_and_user).with(@raid, @user).returns([signup])

      @presenter.signup_status_for(@user, @raid).must_equal :available
    end

    it "returns :cancelled if current user has a cancelled character" do
      signup = Signup.new
      signup.acceptance_status = :cancelled

      ListSignups.expects(:for_raid_and_user).with(@raid, @user).returns([signup])

      @presenter.signup_status_for(@user, @raid).must_equal :cancelled
    end

    it "returns the best status if there are multiple for this raid" do
      signup1 = Signup.new
      signup1.acceptance_status = :cancelled

      signup2 = Signup.new
      signup2.acceptance_status = :available

      signup3 = Signup.new
      signup3.acceptance_status = :accepted

      ListSignups.expects(:for_raid_and_user).with(@raid, @user).returns([
        signup1, signup2, signup3
      ])

      @presenter.signup_status_for(@user, @raid).must_equal :accepted
    end

    it "returns empty string if no signup for current user" do
      ListSignups.expects(:for_raid_and_user).with(@raid, @user).returns([])
      @presenter.signup_status_for(@user, @raid).must_equal ""
    end
  end
end

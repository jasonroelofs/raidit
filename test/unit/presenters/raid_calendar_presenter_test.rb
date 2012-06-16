require 'unit/test_helper'
require 'active_support/core_ext/numeric/time'
require 'active_support/core_ext/date/acts_like'
require 'active_support/core_ext/date/calculations'
require 'active_support/core_ext/date/conversions'
require 'presenters/raid_calendar_presenter'
require 'models/raid'

describe RaidCalendarPresenter do
  it "exists" do
    RaidCalendarPresenter.new(nil).wont_be_nil
  end

  it "takes a raid finder object in the constructor" do
    p = RaidCalendarPresenter.new "raid_finder"
    p.raid_finder.must_equal "raid_finder"
  end

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
    class RaidFinderTester
      attr_accessor :raids

      def run(date)
        @raids.select {|r|
          r.when == date
        }
      end
    end

    before do
      @finder = RaidFinderTester.new

      @presenter = RaidCalendarPresenter.new @finder
      @presenter.start_date = Date.parse("2012/07/01")
    end

    it "returns the list of raids viewable to the user on the given day" do
      @finder.raids = [
        r1 = Raid.new(:when => Date.parse("2012/06/30")),
        r2 = Raid.new(:when => Date.parse("2012/07/01")),
        r3 = Raid.new(:when => Date.parse("2012/07/01")),
        r4 = Raid.new(:when => Date.parse("2012/07/02")),
      ]

      @presenter.raids_on(Date.parse("2012/06/30")).must_equal [r1]
      @presenter.raids_on(Date.parse("2012/07/01")).must_equal [r2, r3]
      @presenter.raids_on(Date.parse("2012/07/02")).must_equal [r4]
      @presenter.raids_on(Date.parse("2012/07/03")).must_equal []
    end
  end
end
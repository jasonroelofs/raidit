require 'unit/test_helper'
require 'interactors/schedule_raid'
require 'models/user'
require 'models/guild'
require 'time'

describe ScheduleRaid do

  it "takes the current user and guild in constructor" do
    user = User.new
    guild = Guild.new
    action = ScheduleRaid.new user, guild

    action.current_user.must_equal user
    action.current_guild.must_equal guild
  end

  it "can be given a raid to update" do
    r = Raid.new
    action = ScheduleRaid.new nil
    action.current_raid = r
    action.current_raid.must_equal r
  end

  describe "#run" do

    before do
      @user = User.new
      @when = Date.today
      @start = Time.parse("20:00")
      @where = "ICC"

      @action = ScheduleRaid.new @user
    end

    it "errors if guild is set and user is not of the guild"

    it "errors if guild is set and user is not raid leader of guild"

    it "saves the raid to the repo if valid" do
      @action.run @where, @when, @start

      raid = Repository.for(Raid).all.first
      raid.wont_be_nil

      raid.owner.must_equal @user
      raid.where.must_equal @where
      raid.when.must_equal @when
      raid.start_at.must_equal @start
      raid.leader.must_equal @user

      raid.invite_at.must_equal Time.parse("19:45")
    end

    it "saves the given roles to the raid if given" do
      roles = {
        :tank => 5,
        :dps => 4,
        :heal => 3
      }

      @action.run @where, @when, @start, roles

      raid = Repository.for(Raid).all.first
      raid.wont_be_nil

      raid.role_limit(:tank).must_equal 5
      raid.role_limit(:dps).must_equal 4
      raid.role_limit(:heal).must_equal 3
    end

    describe "updating an existing raid" do
      before do
        @raid = Raid.new where: @where, when: @when, start_at: @start
        Repository.for(Raid).save(@raid)
      end

      it "can update the given raid instead of creating a new one" do
        @action.current_raid = @raid

        @action.run "Ulduar", Date.parse("2010/01/01"), Time.parse("10:30"), {
          :tank => 1, :dps => 2, :heal => 3
        }

        raids = Repository.for(Raid).all
        raids.length.must_equal 1
        raid = raids.first

        raid.role_limit(:tank).must_equal 1
        raid.role_limit(:dps).must_equal 2
        raid.role_limit(:heal).must_equal 3
      end
    end

  end
end

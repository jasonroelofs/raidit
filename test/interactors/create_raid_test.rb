require 'test_helper'
require 'interactors/create_raid'
require 'models/user'
require 'models/guild'

describe CreateRaid do
  it "exists" do
    CreateRaid.new.wont_be_nil
  end

  it "takes a datetime" do
    action = CreateRaid.new
    time = Time.now

    action.when = time
    action.when.must_equal time
  end

  it "takes a raid leader" do
    leader = User.new
    action = CreateRaid.new

    action.leader = leader
    action.leader.must_equal leader
  end

  it "takes a guild" do
    guild = Guild.new
    action = CreateRaid.new

    action.guild = guild
    action.guild.must_equal guild
  end

  describe "#run" do

    before do
      @action = CreateRaid.new
      @leader = User.new
      @when = Time.now

      @action.when = @when
      @action.leader = @leader
    end

    it "errors if no time set" do
      @action.when = nil

      -> {
        @action.run
      }.must_raise RuntimeError
    end

    it "errors if no leader" do
      @action.leader = nil

      -> {
        @action.run
      }.must_raise RuntimeError
    end

    it "errors if guild is set and user is not of the guild"

    it "errors if guild is set and user is not raid leader of guild"

    it "saves the raid to the repo if valid" do
      @action.run

      raid = Repository.for(Raid).all.first
      raid.wont_be_nil
      raid.when.must_equal @when
      raid.leader.must_equal @leader
    end

  end
end
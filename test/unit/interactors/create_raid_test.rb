require 'test_helper'
require 'interactors/create_raid'
require 'models/user'
require 'models/guild'

describe CreateRaid do
  it "exists" do
    CreateRaid.new(nil).wont_be_nil
  end

  it "takes the current user and guild in constructor" do
    user = User.new
    guild = Guild.new
    action = CreateRaid.new user, guild

    action.current_user.must_equal user
    action.current_guild.must_equal guild
  end

  describe "#run" do

    before do
      @user = User.new
      @when = Time.now
      @action = CreateRaid.new @user
    end

    it "errors if guild is set and user is not of the guild"

    it "errors if guild is set and user is not raid leader of guild"

    it "saves the raid to the repo if valid" do
      @action.run @when

      raid = Repository.for(Raid).all.first
      raid.wont_be_nil
      raid.when.must_equal @when
      raid.leader.must_equal @user
    end

  end
end
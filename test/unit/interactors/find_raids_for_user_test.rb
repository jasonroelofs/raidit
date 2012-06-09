require 'unit/test_helper'
require 'interactors/find_raids_for_user'
require 'models/user'
require 'models/raid'

describe FindRaidsForUser do
  it "exists" do
    FindRaidsForUser.new(nil).wont_be_nil
  end

  it "takes the current user in constructor" do
    user = User.new
    action = FindRaidsForUser.new user
    action.current_user.must_equal user
  end

  describe "#run" do
    before do
      @user = User.new
      @action = FindRaidsForUser.new @user
    end

    it "returns empty list if no raids" do
      @action.run.must_equal []
    end

    it "finds all raids owned by the user (reverse when order)" do
      r1 = Raid.new owner: @user, when: Date.parse("2012/03/01")
      r2 = Raid.new owner: @user, when: Date.parse("2012/04/01")
      r3 = Raid.new
      Repository.for(Raid).save r1
      Repository.for(Raid).save r2
      Repository.for(Raid).save r3

      @action.run.must_equal [r2, r1]
    end
  end
end

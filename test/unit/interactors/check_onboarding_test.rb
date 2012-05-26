require 'unit/test_helper'
require 'interactors/check_onboarding'
require 'models/user'

describe CheckOnboarding do
  it "exists" do
    CheckOnboarding.new(nil).wont_be_nil
  end

  it "takes the current user in constructor" do
    user = User.new
    action = CheckOnboarding.new user
    action.current_user.must_equal user
  end

  describe "#run" do
    before do
      @user = User.new
      @action = CheckOnboarding.new @user
    end

    it "returns true if the user doesn't have a value for the given flag" do
      @action.run(:test_flag).must_equal true
    end

    it "returns the value set for the given flag" do
      @user.set_onboarding_flag :test_flag, "johnson"
      @action.run(:test_flag).must_equal "johnson"
    end
  end
end
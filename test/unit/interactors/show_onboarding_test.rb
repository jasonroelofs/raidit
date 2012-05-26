require 'unit/test_helper'
require 'interactors/show_onboarding'
require 'models/user'

describe ShowOnboarding do
  it "exists" do
    ShowOnboarding.new(nil).wont_be_nil
  end

  it "takes the current user in constructor" do
    user = User.new
    action = ShowOnboarding.new user
    action.current_user.must_equal user
  end

  describe "#run" do
    before do
      @user = User.new
      @action = ShowOnboarding.new @user
    end

    it "returns true if the user doesn't have a value for the given flag" do
      @action.run(:test_flag).must_equal true
    end

    it "returns false if the flag is set" do
      @user.onboarded! :test_flag
      @action.run(:test_flag).must_equal false
    end
  end
end
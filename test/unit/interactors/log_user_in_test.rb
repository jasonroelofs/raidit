require 'unit/test_helper'
require 'interactors/log_user_in'

describe LogUserIn do

  it "takes a login type on construction" do
    action = LogUserIn.new :web
    action.login_type.must_equal :web
  end

  describe "#run" do
    before do
      @user = User.new login: "johnson", password: "abc123"
      Repository.for(User).save(@user)
    end

    it "returns the user if user found for login and password" do
      action = LogUserIn.new :web
      user = action.run "johnson", "abc123"
      user.wont_be_nil

      user.must_equal @user
    end

    it "returns false if no user found" do
      action = LogUserIn.new :web
      action.run("unknown", "badpass").must_be_nil
    end

    it "returns false if password isn't right" do
      action = LogUserIn.new :web
      action.run("johnson", "badpass").must_be_nil
    end

    it "sets a new login token of the given type on the user when successful" do
      action = LogUserIn.new :web
      user = action.run "johnson", "abc123"

      user.login_token(:web).wont_be_nil
    end

    it "uses a different login token for every successful log in" do
      action = LogUserIn.new :web
      user = action.run "johnson", "abc123"
      token1 = user.login_token(:web)

      user = action.run "johnson", "abc123"
      user.login_token(:web).wont_equal token1
    end
  end

end

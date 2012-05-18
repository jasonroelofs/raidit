require 'unit/test_helper'
require 'models/user'

describe User do
  it "exists" do
    User.new.wont_be_nil
  end

  it "takes attributes in a hash" do
    u = User.new email: "email"
    u.email.must_equal "email"
  end

  describe "login tokens" do
    it "defaults to nil token" do
      u = User.new
      u.login_token(:web).must_be_nil
      u.login_token(:boomer).must_be_nil
    end

    it "has typed login token" do
      u = User.new
      u.set_login_token :web, "session token"
      u.login_token(:web).must_equal "session token"
    end
  end
end

require 'unit/test_helper'
require 'models/user'

describe User do

  it "is an entity" do
    User.ancestors.must_include Entity
  end

  it "takes attributes in a hash" do
    u = User.new email: "email", login: "login", password: "pass"
    u.login.must_equal "login"
    u.email.must_equal "email"

    # must_equal does something scewy with == to where it
    # doesn't work here
    u.password.must_be :==, "pass"
  end

  describe "passwords" do
    it "hashes the incoming password using bcrypt" do
      u = User.new
      u.password = "anewpass"

      u.password_hash.wont_be_nil
      u.password_hash.length.must_be :>, 20
    end

    it "returns a comparator object for password checks" do
      u = User.new
      u.password = "anewpass"

      # See test above
      u.password.must_be :==, "anewpass"
      u.password.wont_be :==, "someotherpass"
    end
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

  describe "onboarding flags" do
    it "returns true if no flag set" do
      u = User.new
      u.requires_onboarding?(:testing).must_equal true
    end

    it "returns the set value of an onboarding flag" do
      u = User.new
      u.onboarded! :testing
      u.requires_onboarding?(:testing).must_equal false
    end
  end
end

require 'unit/test_helper'
require 'models/user'
require 'interactors/find_user'

describe FindUser do

  describe "#by_login_token" do
    it "can find a user by a login token of the given type" do
      user = User.new
      user.set_login_token :web, "token"
      Repository.for(User).save user

      found = FindUser.by_login_token :web, "token"

      found.must_equal user
    end

    it "keeps different login tokens seperate" do
      user = User.new
      user.set_login_token :web, "token"

      user2 = User.new
      user2.set_login_token :api, "token"

      Repository.for(User).save user
      Repository.for(User).save user2

      found = FindUser.by_login_token :api, "token"

      found.must_equal user2
    end

    it "returns nil if the requested token is nil" do
      user = User.new
      Repository.for(User).save user

      found = FindUser.by_login_token :web, nil

      found.must_be_nil
    end
  end

  describe "#by_login" do
    it "finds a user by login" do
      user = User.new login: "markus"
      Repository.for(User).save user

      FindUser.by_login("markus").must_equal user
    end
  end

end

require 'test_helper'
require 'repositories/user_repository'
require 'models/user'

describe UserRepository do
  it "exists" do
    UserRepository.new.wont_be_nil
  end

  describe ".all" do
    it "returns the full list of users" do
      UserRepository.all.must_equal []
    end
  end

  describe ".save" do
    it "sends a user object into the data store" do
      user = User.new email: "email@me.com"
      UserRepository.save user

      UserRepository.all.must_equal [user]
    end
  end
end

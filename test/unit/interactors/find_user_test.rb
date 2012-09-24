require 'unit/test_helper'
require 'models/user'
require 'models/guild'
require 'models/character'
require 'interactors/find_user'

describe FindUser do

  describe ".by_login_token" do
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

  describe ".by_login" do
    it "finds a user by login" do
      user = User.new login: "markus"
      Repository.for(User).save user

      FindUser.by_login("markus").must_equal user
    end
  end

  describe ".by_guild_and_id" do
    before do
      @user1 = User.new id: 1
      @user2 = User.new id: 2

      @guild1 = Guild.new id: 1
      @guild2 = Guild.new id: 2
      @guild3 = Guild.new id: 3

      @char1 = Character.new user: @user1, guild: @guild1, :is_main => true
      @char2 = Character.new user: @user2, guild: @guild2, :is_main => true

      Repository.for(User).save(@user1)
      Repository.for(User).save(@user2)

      Repository.for(Character).save(@char1)
      Repository.for(Character).save(@char2)
    end

    it "finds the user who's a member of the given guild" do
      FindUser.by_guild_and_id(@guild1, 1).must_equal @user1
    end

    it "returns nil if no such user" do
      FindUser.by_guild_and_id(@guild1, 4).must_be_nil
    end

    it "returns nil if user isnt in the guild" do
      FindUser.by_guild_and_id(@guild1, 2).must_be_nil
    end

  end

end

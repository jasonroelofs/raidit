require 'unit/test_helper'
require 'interactors/list_characters'
require 'models/user'
require 'models/guild'
require 'models/character'

describe ListCharacters do

  it "takes a user on construction" do
    user = User.new
    action = ListCharacters.new user
    action.user.must_equal user
  end

  describe "#guilded and #unguilded" do
    before do
      @user = User.new
      @guild = Guild.new
      @char1 = Character.new name: "Wonko", user: @user, guild: @guild
      @char2 = Character.new name: "Feeler", user: @user, guild: nil

      Repository.for(Character).save(@char1)
      Repository.for(Character).save(@char2)

      @action = ListCharacters.new @user
    end

    it "finds all characters in a guild" do
      found = @action.guilded

      found.wont_be_nil
      found.guilds.must_equal [@guild]
      found.characters.must_equal({@guild.id => [@char1]})
    end

    it "groups results by guild" do
      found = @action.unguilded

      found.wont_be_nil
      found.must_equal [@char2]
    end
  end

  describe "#run" do
    it "finds all characters for the given user" do
      user = User.new
      character = Character.new name: "Johnson", user: user
      Repository.for(Character).save character
      action = ListCharacters.new user

      action.run.must_equal [character]
    end

    it "returns the empty list if no characters found" do
      user = User.new
      action = ListCharacters.new user

      action.run.must_equal []
    end
  end

end

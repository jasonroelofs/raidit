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

  describe "#all_grouped_by_guild" do
    before do
      @user = User.new
      @guild = Guild.new id: 1, name: "My Guild"
      @char1 = Character.new name: "Wonko", user: @user, guild: @guild
      @char2 = Character.new name: "Feeler", user: @user, guild: nil

      Repository.for(Character).save(@char2)
      Repository.for(Character).save(@char1)

      @action = ListCharacters.new @user
    end

    it "finds all characters in a guild" do
      found = @action.all_grouped_by_guild

      found.wont_be_nil
      found.guilds.must_equal [@guild, Guild.new(id: -1, name: "Unguilded")]
      found.characters.must_equal({
        @guild.id => [@char1],
        -1 => [@char2]
      })
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

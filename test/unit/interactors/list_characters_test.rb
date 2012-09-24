require 'unit/test_helper'
require 'interactors/list_characters'
require 'models/user'
require 'models/guild'
require 'models/character'

describe ListCharacters do

  describe ".all_for_user" do
    it "finds all characters for the given user" do
      user = User.new
      character = Character.new name: "Johnson", user: user
      Repository.for(Character).save character

      list = ListCharacters.all_for_user user
      list.must_equal [character]
    end

    it "returns the empty list if no characters found" do
      user = User.new

      list = ListCharacters.all_for_user user
      list.must_equal []
    end
  end

  describe ".all_in_guild" do
    it "finds all Main characters in the given guild" do
      user = User.new
      Repository.for(User).save(user)

      guild = Guild.new
      Repository.for(Guild).save(guild)

      char1 = Character.new name: "John", user: user, guild: guild
      char2 = Character.new name: "Mark", user: user, guild: guild
      char3 = Character.new name: "Meeps", guild: guild
      char4 = Character.new name: "Dot"

      Repository.for(Character).save(char1)
      Repository.for(Character).save(char2)
      Repository.for(Character).save(char3)
      Repository.for(Character).save(char4)

      list = ListCharacters.all_in_guild(guild)
      list.must_equal [char1, char2, char3]
    end
  end

  describe ".for_user_in_guild" do
    it "finds only the characters for the given user in the current guild, main first" do
      user = User.new
      guild = Guild.new

      char1 = Character.new name: "Mark", user: user, guild: guild
      char2 = Character.new name: "John", user: user, guild: guild, is_main: true
      char3 = Character.new name: "Meeps", guild: guild
      char4 = Character.new name: "Dot", user: user

      Repository.for(Character).save(char1)
      Repository.for(Character).save(char2)
      Repository.for(Character).save(char3)
      Repository.for(Character).save(char4)

      list = ListCharacters.for_user_in_guild(user, guild)
      list.must_equal [char2, char1]
    end
  end

end

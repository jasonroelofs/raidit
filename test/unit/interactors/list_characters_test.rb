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

end

require 'unit/test_helper'
require 'interactors/list_characters'
require 'models/user'
require 'models/character'

describe ListCharacters do
  it "exists" do
    ListCharacters.new(nil).wont_be_nil
  end

  it "takes a user on construction" do
    user = User.new
    action = ListCharacters.new user
    action.user.must_equal user
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

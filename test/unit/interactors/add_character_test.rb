require 'unit/test_helper'
require 'interactors/add_character'
require 'models/user'
require 'models/character'

describe AddCharacter do

  it "takes the current user in construction" do
    user = User.new
    action = AddCharacter.new user
    action.current_user.must_equal user
  end

  describe "#run" do
    before do
      @user = User.new
      @action = AddCharacter.new @user
    end

    it "creates a new character for the user" do
      @action.run "Wonko"

      characters = Repository.for(Character).find_all_for_user(@user)
      characters.length.must_equal 1

      c = characters.first

      c.name.must_equal "Wonko"
    end
  end

end

require 'unit/test_helper'
require 'interactors/add_character'
require 'models/user'
require 'models/guild'
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
      assert @action.run("Wonko", "warrior")

      characters = Repository.for(Character).find_all_for_user(@user)
      characters.length.must_equal 1

      c = characters.first

      c.name.must_equal "Wonko"
      c.character_class.must_equal "warrior"
    end

    it "associates character to given guild if a guild_id is given" do
      guild = Guild.new
      Repository.for(Guild).save(guild)

      @action.run "Wonko", "warrior", guild.id

      wonko = Repository.for(Character).find_all_for_user(@user).first
      wonko.guild.must_equal guild
    end

    it "returns false and doesn't save if invalid" do
      assert !@action.run("", "warrior")

      characters = Repository.for(Character).find_all_for_user(@user)
      characters.length.must_equal 0

      char = @action.character
      char.name.must_equal ""
      char.character_class.must_equal "warrior"
    end
  end

end

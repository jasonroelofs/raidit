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
      assert @action.run(:name => "Wonko", :character_class => "warrior")

      characters = Repository.for(Character).find_all_for_user(@user)
      characters.length.must_equal 1

      c = characters.first

      c.name.must_equal "Wonko"
      c.character_class.must_equal "warrior"
    end

    it "associates character to given guild if a guild_id is given" do
      guild = Guild.new
      Repository.for(Guild).save(guild)

      @action.run :name => "Wonko", :character_class => "warrior", :guild_id => "#{guild.id}"

      wonko = Repository.for(Character).find_all_for_user(@user).first
      wonko.guild.must_equal guild
    end

    it "returns false and doesn't save if invalid" do
      assert !@action.run(:name => "", :character_class => "warrior")

      characters = Repository.for(Character).find_all_for_user(@user)
      characters.length.must_equal 0

      char = @action.character
      char.name.must_equal ""
      char.character_class.must_equal "warrior"
    end

    it "can create a new guild and associate the character to that guild if requested" do
      assert @action.run(:name => "Guildy", :character_class => "mage", :guild_id => "new_guild",
                         :guild => {:region => "US", :server => "Johnson", :name => "BlastOff"})

      guild = Repository.for(Guild).find_by_name("BlastOff")
      guild.region.must_equal "US"
      guild.server.must_equal "Johnson"

      guildy = Repository.for(Character).find_all_for_user(@user).first
      guildy.guild.must_equal guild
    end
  end

end

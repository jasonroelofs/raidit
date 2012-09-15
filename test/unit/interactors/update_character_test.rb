require 'unit/test_helper'
require 'interactors/update_character'

describe UpdateCharacter do

  before do
    Repository.for(Character).save(
      Character.new(:name => "Charizard", :character_class => "mage")
    )

    @character = Repository.for(Character).all.first
  end

  it "updates the current character with new information" do
    action = UpdateCharacter.new @character
    assert action.run(:name => "Johnson", :character_class => "druid")

    char = Repository.for(Character).find(@character.id)
    char.name.must_equal "Johnson"
    char.character_class.must_equal "druid"
  end

  it "errors if the character values are invalid" do
    action = UpdateCharacter.new @character
    assert !action.run(:name => "")

    char = Repository.for(Character).find(@character.id)
    char.name.must_equal "Charizard"
  end

  it "updates the character's guild if guild_id given" do
    Repository.for(Guild).save(
      Guild.new(:name => "Stealer")
    )
    guild = Repository.for(Guild).all.first

    action = UpdateCharacter.new @character
    assert action.run(:name => "Johnson", :character_class => "druid", :guild_id => guild.id)

    char = Repository.for(Character).find(@character.id)
    char.guild.wont_be_nil
    char.guild.id.must_equal guild.id
  end

  it "updates character to a new guild if requested" do
    action = UpdateCharacter.new @character
    assert action.run(:name => "Johnson", :character_class => "druid", :guild_id => "new_guild",
                     :guild => {:name => "Coffee Drinkers", :server => "Detheroc", :region => "US"})

    guild = Repository.for(Guild).all.first
    guild.name.must_equal "Coffee Drinkers"

    char = Repository.for(Character).find(@character.id)
    char.guild.wont_be_nil
    char.guild.must_equal guild
  end

end

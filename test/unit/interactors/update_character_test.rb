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

end

require 'unit/test_helper'
require 'interactors/select_main_character'
require 'models/guild'
require 'models/character'

describe SelectMainCharacter do

  it "flags the given character as the new Main for the guild" do
    guild = Guild.new
    new_main = Character.new guild: guild

    Repository.for(Guild).save(guild)
    Repository.for(Character).save(new_main)

    SelectMainCharacter.run new_main

    assert new_main.main?
  end

  it "un-mains all characters in the given character's guild" do
    guild = Guild.new
    new_main = Character.new guild: guild
    old_main = Character.new guild: guild, is_main: true

    Repository.for(Guild).save(guild)
    Repository.for(Character).save(new_main)
    Repository.for(Character).save(old_main)

    SelectMainCharacter.run new_main

    assert !Repository.for(Character).find(old_main.id).main?
  end

  it "does nothing if the character has no guild" do
    new_main = Character.new
    Repository.for(Character).save(new_main)

    SelectMainCharacter.run new_main

    assert !new_main.main?
  end

end

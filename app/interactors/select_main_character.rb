require 'repository'
require 'models/character'
require 'repository'

class SelectMainCharacter

  def self.run(new_main_character)
    return unless new_main_character.guild

    current_main_character = Repository.for(Character).find_main_character(
      new_main_character.user, new_main_character.guild
    )

    if current_main_character
      current_main_character.is_main = false
      Repository.for(Character).save current_main_character
    end

    new_main_character.is_main = true
    Repository.for(Character).save new_main_character
  end

end

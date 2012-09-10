require 'repository'
require 'models/character'

class UpdateCharacter

  def initialize(current_character)
    @current_character = current_character
  end

  ##
  #
  ##
  def run(attributes)
    @current_character.name = attributes[:name] if attributes[:name]
    @current_character.character_class = attributes[:character_class] if attributes[:character_class]

    if @current_character.valid?
      Repository.for(Character).save(@current_character)
    else
      false
    end
  end

end

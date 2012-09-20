require 'repository'
require 'interactors/find_or_add_guild'
require 'models/character'

class UpdateCharacter

  attr_reader :current_character

  def initialize(current_character)
    @current_character = current_character
  end

  def run(attributes)
    @current_character.name = attributes[:name] if attributes[:name]
    @current_character.character_class = attributes[:character_class] if attributes[:character_class]

    @current_character.guild = FindOrAddGuild.new(@current_character.user).from_attributes(attributes)

    if @current_character.valid?
      Repository.for(Character).save(@current_character)
    else
      false
    end
  end

end

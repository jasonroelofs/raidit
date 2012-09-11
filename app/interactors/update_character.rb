require 'repository'
require 'interactors/find_guild'
require 'models/character'
require 'models/guild'

class UpdateCharacter

  attr_reader :current_character

  def initialize(current_character)
    @current_character = current_character
  end

  ##
  #
  ##
  def run(attributes)
    @current_character.name = attributes[:name] if attributes[:name]
    @current_character.character_class = attributes[:character_class] if attributes[:character_class]

    if attributes[:guild_id].present?
      @current_character.guild = FindGuild.by_id(attributes[:guild_id].to_i)
    end

    if @current_character.valid?
      Repository.for(Character).save(@current_character)
    else
      false
    end
  end

end

require 'repository'
require 'interactors/find_guild'
require 'interactors/add_guild'
require 'models/character'
require 'models/guild'

class UpdateCharacter

  attr_reader :current_character

  def initialize(current_character)
    @current_character = current_character
  end

  def run(attributes)
    @current_character.name = attributes[:name] if attributes[:name]
    @current_character.character_class = attributes[:character_class] if attributes[:character_class]

    @current_character.guild = find_or_create_guild(attributes)

    if @current_character.valid?
      Repository.for(Character).save(@current_character)
    else
      false
    end
  end

  protected

  def find_or_create_guild(attributes)
    guild_id, guild_attrs = attributes.values_at :guild_id, :guild

    if guild_attrs && guild_id == "new_guild"
      AddGuild.from_attributes(guild_attrs)
    elsif guild_id.present?
      FindGuild.by_id(guild_id.to_i)
    else
      nil
    end
  end

end

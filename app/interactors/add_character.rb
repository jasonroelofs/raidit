require 'models/character'
require 'interactors/find_guild'
require 'interactors/add_guild'
require 'repository'

class AddCharacter

  attr_reader :current_user, :character

  def initialize(current_user)
    @current_user = current_user
  end

  ##
  # Given the current_user, add a Character to this user.
  # Expected attributes:
  #
  #   :name
  #   :character_class
  #   :guild_id
  #
  # If :guild_id == "new_guild" then will try to create a new guild
  # with the given attributes:
  #
  #   :guild :name
  #   :guild :region
  #   :guild :server
  #
  ##
  def run(attributes)
    name, character_class = attributes.values_at :name, :character_class

    guild = find_or_create_guild attributes

    @character = Character.new name: name, user: @current_user,
      character_class: character_class, guild: guild

    if @character.valid?
      Repository.for(Character).save @character
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

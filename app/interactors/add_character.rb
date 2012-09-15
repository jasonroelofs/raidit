require 'models/character'
require 'interactors/find_guild'
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
    name, character_class, guild_id = attributes.values_at :name, :character_class, :guild_id

    if attributes[:guild] && guild_id == "new_guild"
      guild = Guild.new attributes[:guild]
      Repository.for(Guild).save(guild)
    else
      guild = guild_id.present? ? FindGuild.by_id(guild_id.to_i) : nil
    end

    @character = Character.new name: name, user: @current_user,
      character_class: character_class, guild: guild

    if @character.valid?
      Repository.for(Character).save @character
    else
      false
    end
  end
end

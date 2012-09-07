require 'models/character'
require 'interactors/find_guild'
require 'repository'

class AddCharacter

  attr_reader :current_user

  def initialize(current_user)
    @current_user = current_user
  end

  ##
  # Given the current_user, add a Character to this user
  ##
  def run(name, character_class, guild_id = nil)
    guild = guild_id ? FindGuild.by_id(guild_id) : nil

    character = Character.new name: name, user: @current_user, character_class: character_class,
      guild: guild

    Repository.for(Character).save character
  end
end

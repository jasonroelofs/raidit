require 'enumerator'
require 'models/guild'

##
# Given a list of characters, this object pulls them apart and maps
# the characters underneath the guild they are in.
#
# Iterate through the final list with #each, or the raw list of guilds
# with #guilds. The guilds are sorted by name, alphabetically, with
# an Unguilded pseudo-guild added to the end of the list.
##
class CharactersByGuild
  include Enumerable

  def initialize(character_list)
    @characters_by_guild = {}
    @guild_id_map = {}
    @unguilded = Guild.new id: -1, name: "Unguilded"

    initialize_guild_list character_list
  end

  def empty?
    @characters_by_guild.empty?
  end

  ##
  # Return the list of known guilds, sorted alphabetically
  # though ensuring the "Unguilded" guild is at the bottom
  # of the list.
  ##
  def guilds
    @guild_id_map.values.sort do |a, b|
      if a.name == "Unguilded"
        1
      elsif b.name == "Unguilded"
        -1
      else
        a.name <=> b.name
      end
    end
  end

  def each
    guilds.each do |guild|
      yield guild, @characters_by_guild[guild.id]
    end
  end

  protected

  def initialize_guild_list(character_list)
    character_list.each do |character|
      guild = character.guild || @unguilded

      @guild_id_map[guild.id] ||= guild
      @characters_by_guild[guild.id] ||= []
      @characters_by_guild[guild.id] << character
    end
  end
end


require 'repository'
require 'models/character'

class ListCharacters

  attr_accessor :user

  def initialize(user)
    @user = user
  end

  def run
    Repository.for(Character).find_all_for_user @user
  end

  ##
  # Find all characters owned by the current user, mapped by
  # the guild the characters are in.
  #
  # Unguilded characters will be put in a pseudo-guild named Unguilded
  #
  # Returned is a hash of:
  #
  #   guild => [list of characters]
  ##
  def all_grouped_by_guild
    map_characters_by_guild self.run
  end

  def map_characters_by_guild(characters)
    mapping = CharactersByGuild.new

    characters.each do |character|
      mapping.add_character_to_guild character, character.guild
    end

    mapping
  end
  private :map_characters_by_guild

  class CharactersByGuild
    attr_reader :characters

    def initialize
      @guild_id_map = {}
      @characters = {}
      @unguilded = Guild.new id: -1, name: "Unguilded"
    end

    def add_character_to_guild(character, guild)
      guild ||= @unguilded

      @guild_id_map[guild.id] ||= guild

      @characters[guild.id] ||= []
      @characters[guild.id] << character
    end

    def empty?
      @guild_id_map.empty?
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
        yield guild, @characters[guild.id]
      end
    end
  end

end

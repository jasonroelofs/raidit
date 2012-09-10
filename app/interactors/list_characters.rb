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
  # Find all characters for this user who are in a guild.
  # Returned is a hash of:
  #
  #   guild => [list of characters]
  ##
  def guilded
    characters = find_guilded_characters
    map_characters_by_guild characters
  end

  def find_guilded_characters
    self.run.select do |character|
      character.guild.present?
    end
  end
  private :find_guilded_characters

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
    end

    def add_character_to_guild(character, guild)
      @guild_id_map[guild.id] ||= guild

      @characters[guild.id] ||= []
      @characters[guild.id] << character
    end

    def empty?
      @guild_id_map.empty?
    end

    def guilds
      @guild_id_map.values
    end

    def each
      guilds.each do |guild|
        yield guild, @characters[guild.id]
      end
    end
  end

  ##
  # Find all characters for this user who are *not* in a guild.
  #
  # Returns an array of found Characters
  ##
  def unguilded
    find_unguilded_characters
  end

  def find_unguilded_characters
    self.run.select do |character|
      character.guild.nil?
    end
  end
  private :find_unguilded_characters

end

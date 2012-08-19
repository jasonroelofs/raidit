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
    self.run.select do |character|
      character.guild.present?
    end.inject({}) do |memo, character|
      memo[character.guild] ||= []
      memo[character.guild] << character
      memo
    end
  end

  ##
  # Find all characters for this user who are *not* in a guild.
  #
  # Returns an array of found Characters
  ##
  def unguilded
    self.run.select do |character|
      character.guild.nil?
    end
  end

end

require 'repository'
require 'models/character'

class ListCharacters

  def self.all_for_user(user)
    Repository.for(Character).find_all_for_user user
  end

  def self.all_in_guild(guild)
    Repository.for(Character).find_all_in_guild(guild)
  end

  def self.for_user_in_guild(user, guild)
    Repository.for(Character).find_all_for_user_in_guild(user, guild)
  end

end

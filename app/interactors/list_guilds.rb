require 'repository'
require 'models/guild'

class ListGuilds

  ##
  # Find all guilds this user is a member of
  ##
  def self.by_user(user)
    # Ick...
    Repository.for(Character).find_all_for_user(user).select do |char|
      char.guild.present?
    end.map(&:guild).uniq
  end

  ##
  # Find all guilds who's name matches the query
  ##
  def self.by_partial_name(query)
    Repository.for(Guild).search_by_name(query)
  end

end

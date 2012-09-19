require 'repository'
require 'interactors/list_guilds'

class FindGuild

  def self.by_id(id)
    Repository.for(Guild).find id
  end

  def self.by_name(name)
    Repository.for(Guild).find_by_name name
  end

  def self.by_user_and_id(user, id)
    ListGuilds.by_user(user).find do |guild|
      guild.id == id
    end
  end

end

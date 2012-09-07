require 'interactors/list_characters'

class ListGuilds

  ##
  # Find all guilds this user is a member of
  ##
  def self.by_user(user)
    ListCharacters.new(user).guilded.keys
  end

end

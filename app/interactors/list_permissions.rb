require 'repository'
require 'models/permission'

class ListPermissions

  def self.for_user_in_guild(user, guild)
    Repository.for(Permission).find_by_user_and_guild(user, guild) ||
      Permission.empty(user, guild)
  end

end

require 'repository'
require 'models/permission'
require 'interactors/list_permissions'

class UpdatePermissions

  def initialize(user, guild)
    @current_user = user
    @current_guild = guild
  end

  def run(*new_permissions_list)
    user_permissions = ListPermissions.for_user_in_guild(@current_user, @current_guild)
    user_permissions.reset!

    new_permissions_list.each do |perm|
      user_permissions.allow(perm)
    end

    Repository.for(Permission).save(user_permissions)
  end

end

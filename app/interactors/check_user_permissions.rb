require 'repository'
require 'models/permission'

class CheckUserPermissions

  attr_reader :current_user, :current_guild

  def initialize(current_user, current_guild = nil)
    @current_user = current_user
    @current_guild = current_guild
  end

  def allowed?(permission_key)
    user_permissions = Repository.for(Permission).
      find_by_user_and_guild(@current_user, @current_guild)
    user_permissions ? user_permissions.allows?(permission_key) : false
  end
end

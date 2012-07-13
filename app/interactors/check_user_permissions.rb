require 'repository'
require 'models/permission'

class CheckUserPermissions

  attr_reader :current_user, :current_guild

  attr_accessor :current_raid

  def initialize(current_user, current_guild = nil)
    @current_user = current_user
    @current_guild = current_guild
  end

  def allowed?(permission_key)
    return true if @current_raid && @current_raid.owner == @current_user

    user_permissions = Repository.for(Permission).
      find_by_user_and_guild(@current_user, @current_guild)
    user_permissions ? user_permissions.allows?(permission_key) : false
  end
end

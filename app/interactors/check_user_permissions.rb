require 'interactors/list_permissions'

class CheckUserPermissions

  attr_reader :current_user, :current_guild

  def initialize(current_user, current_guild)
    @current_user = current_user
    @current_guild = current_guild
  end

  def allowed?(permission_key)
    ListPermissions.for_user_in_guild(@current_user, @current_guild).allows?(permission_key)
  end
end

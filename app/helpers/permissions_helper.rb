module PermissionsHelper
  def permission(permission)
    yield if current_user_has_permission? permission
  end
end

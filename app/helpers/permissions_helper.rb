module PermissionsHelper

  def permission?(permission)
    current_user_has_permission? permission
  end

  def permission(permission)
    yield if permission? permission
  end
end

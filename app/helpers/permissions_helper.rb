module PermissionsHelper

  ##
  # If the current user has the given permission set, then execute
  # the given block
  ##
  def permission(permission_key, &block)
    block.call if permission? permission_key
  end

  ##
  # Returns true/false depending on if the current user has
  # the given permission set.
  #
  # +current_user_has_permission?+ comes from ApplicationController
  ##
  def permission?(permission_key)
    current_user_has_permission? permission_key
  end

end

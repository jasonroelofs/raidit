class UserPermissionsController < ApplicationController

  requires_user
  requires_permission :manage_guild_members

  def update
    user = FindUser.by_guild_and_id(current_guild, params[:id].to_i)
    action = UpdatePermissions.new(user, current_guild)

    to_update = Permission::ALL_PERMISSIONS.map do |known_permission|
      known_permission if params[known_permission] == "1"
    end.compact

    action.run(*to_update)
    flash[:notice] = "Permissions updated"
    redirect_to edit_user_path(user)
  end

  protected

  def permission_denied_path
    guilds_path
  end

end

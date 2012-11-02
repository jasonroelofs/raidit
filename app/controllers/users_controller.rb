class UsersController < ApplicationController

  requires_user :only => [:show]
  navigation :guilds, :only => [:show]

  def new
    @user = User.new
  end

  def create
    action = SignUpUser.new
    if action.run params[:user]
      log_in = LogUserIn.new :web
      user = log_in.run params[:user][:login], params[:user][:password]
      set_new_user_session user

      redirect_to root_path
    else
      @user = action.user
      render "new"
    end
  end

  def show
    @user = FindUser.by_guild_and_id(current_guild, params[:id].to_i)
    @characters = ListCharacters.for_user_in_guild(@user, current_guild)

    if @user == current_user || current_user_has_permission?(:manage_guild_members)
      @permissions = ListPermissions.for_user_in_guild(@user, current_guild)
    end
  end

end

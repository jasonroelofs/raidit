class UsersController < ApplicationController

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

end

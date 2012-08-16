class ProfileController < ApplicationController

  requires_user
  navigation :profile

  def show
    @user = current_user
  end

  def update
    action = UpdateUser.new current_user
    if action.run params[:user]
      redirect_to profile_path
    else
      @user = action.user
      render "show"
    end
  end

end

class ProfileController < ApplicationController

  requires_user
  navigation :profile

  def show
    @user = current_user
  end

end

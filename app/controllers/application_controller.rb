class ApplicationController < ActionController::Base
  protect_from_forgery

  layout "application"

  before_filter :authenticate_user!

  before_filter :set_current_guild
  before_filter :set_current_user

  def current_guild
    Guild.current
  end
  helper_method :current_guild

  protected

  def set_current_guild
    Guild.current = "Exiled"
  end

  def set_current_user
    User.current = current_user
  end
end

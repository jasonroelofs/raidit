class ApplicationController < ActionController::Base
  protect_from_forgery

  layout "application"

  before_filter :set_current_guild

  before_filter :authenticate_user!

  def current_guild
    Guild.current
  end
  helper_method :current_guild

  protected

  def set_current_guild
    Guild.current = "Exiled"
  end
end

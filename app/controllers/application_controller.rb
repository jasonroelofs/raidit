class ApplicationController < ActionController::Base
  protect_from_forgery

  layout "application"

  before_filter :set_current_guild
  before_filter :set_current_user

  before_filter :set_time_zone

  def current_guild
    Guild.current
  end
  helper_method :current_guild

  ##
  # Does the current user have the requested role for the current guild?
  ##
  def role?(role)
    current_user && current_user.has_role?(role)
  end
  helper_method :role?

  protected

  def set_time_zone
    Time.zone = "Central Time (US & Canada)"
  end

  def set_current_guild
    Guild.current = "Exiled"
  end

  def set_current_user
    User.current = current_user
  end
end

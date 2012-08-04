class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all

  class << self
    ##
    # Flag the actions that require a current user
    ##
    def requires_user(options = {})
      before_filter :require_user, options
    end
  end

  ##
  # Returns the currently logged in user
  ##
  def current_user
    @current_user ||= find_logged_in_user
  end
  helper_method :current_user

  ##
  # Returns the currently selected guild of the currently logged
  # in user
  ##
  def current_guild
    if current_user
      @current_guild || find_current_guild
    end
  end
  helper_method :current_guild

  ##
  # Check if the current user has the given permission set
  # for the currently selected guild
  ##
  def current_user_has_permission?(permission)
    CheckUserPermissions.new(current_user, current_guild).allowed?(permission)
  end
  helper_method :current_user_has_permission?

  protected

  def require_user
    redirect_to login_path unless current_user
  end

  def find_logged_in_user
    action = FindUser.new
    action.by_login_token :web, cookies[:web_session_token]
  end

  ##
  # TODO Update this to not be a static choice when the guild
  # selector is built
  ##
  def find_current_guild
    FindGuild.by_name "Exiled"
  end

end

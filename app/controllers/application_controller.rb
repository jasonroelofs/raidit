class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all

  class << self
    ##
    # Flag the actions that require a current user
    #
    # +options+ are passed directly into +before_filter+
    ##
    def requires_user(options = {})
      before_filter :require_user, options
    end

    ##
    # Flag the actions that require a given permissions set for the
    # current user and currently selected guild.
    #
    # +options+ are passed directly into +before_filter+
    ##
    def requires_permission(permission, options = {})
      before_filter(options) do |controller|
        if !controller.current_user_has_permission?(permission)
          redirect_to permission_denied_path
        end
      end
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

  # Override this method in a sub controller to change the path
  # the user is redirected to if they don't have permission to view the current page
  def permission_denied_path
    root_path
  end

  def require_user
    redirect_to login_path unless current_user
  end

  def find_logged_in_user
    FindUser.by_login_token :web, cookies[:web_session_token]
  end

  ##
  # TODO Update this to not be a static choice when the guild
  # selector is built
  ##
  def find_current_guild
    FindGuild.by_name "Exiled"
  end

end

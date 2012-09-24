class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all

  attr_accessor :current_navigation

  class << self
    ##
    # Flag the actions that require a current user
    #
    # +options+ are passed directly into +before_filter+
    ##
    def requires_user(options = {})
      before_filter(options) do |controller|
        if !controller.current_user
          session[:login_redirect_to] = controller.request.path
          redirect_to login_path
        end
      end
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

    ##
    # Set the current navigation section controller-wide
    ##
    def navigation(nav_key, options = {})
      before_filter(options) do |controller|
        controller.current_navigation = nav_key
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

  ##
  # Return the current navigation key
  ##
  def current_navigation
    @current_navigation
  end
  helper_method :current_navigation

  protected

  # Override this method in a sub controller to change the path
  # the user is redirected to if they don't have permission to view the current page
  def permission_denied_path
    root_path
  end

  def find_logged_in_user
    FindUser.by_login_token :web, cookies[:web_session_token]
  end

  def find_current_guild
    if session[:current_guild_id]
      FindGuild.by_user_and_id(current_user, session[:current_guild_id])
    else
      ListGuilds.by_user(current_user).first
    end
  end

  def set_new_user_session(user)
    reset_session
    cookies[:web_session_token] = {
      value: user.login_token(:web),
      httponly: true
    }
  end

end

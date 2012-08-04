class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all

  include AccessControl

  def current_user
    @current_user ||= find_logged_in_user
  end
  helper_method :current_user

  def current_guild
    if current_user
      @current_guild || find_current_guild
    end
  end
  helper_method :current_guild

  protected

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

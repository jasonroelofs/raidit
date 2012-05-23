class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all

  def current_user
    @current_user ||= find_logged_in_user
  end
  helper_method :current_user

  protected

  def find_logged_in_user
    action = FindUser.new
    action.by_login_token :web, cookies[:web_session_token]
  end

end

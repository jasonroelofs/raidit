class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    @current_user ||= find_logged_in_user
  end
  helper_method :current_user

  protected

  def find_logged_in_user
    action = FindUser.new
    action.by_web_session_token cookies[:web_session_token]
  end

end

class SessionsController < ApplicationController

  ##
  # Render the login form
  ##
  def new
    @session = Session.new
  end

  ##
  # Attempt to log the user in
  ##
  def create
    action = LogUserIn.new :web
    @session = Session.new params[:session]

    if user = action.run(@session.login, @session.password)
      previous_path = session[:login_redirect_to]
      set_new_user_session user

      redirect_to previous_path || root_path
    else
      flash.now[:login_error] = true
      render action: "new"
    end
  end

  ##
  # Log the user out
  ##
  def destroy
    cookies.delete :web_session_token
    reset_session
    redirect_to root_path
  end

end

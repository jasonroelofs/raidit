class SessionsController < ApplicationController

  ##
  # Render the login form
  ##
  def new
  end

  ##
  # Attempt to log the user in
  ##
  def create
    action = LogUserIn.new :web

    if user = action.run(params[:login], params[:password])
      previous_path = session[:login_redirect_to]

      reset_session
      cookies[:web_session_token] = {
        value: user.login_token(:web),
        httponly: true
      }

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

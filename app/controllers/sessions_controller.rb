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
      cookies[:web_session_token] = {
        value: user.login_token(:web),
        httponly: true
      }

      redirect_to root_path
    else
      render action: "new"
    end
  end

end

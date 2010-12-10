class ApiController < ApplicationController

  before_filter :validate_request

  # Request a sign in token for a User who's a part of the current guild
  def token
    user = 
      if params[:create]
        User.find_or_create_by_email(params[:email])
      else
        User.find_by_email(params[:email])
      end

    if user
      user.reset_authentication_token!

      render :json => {
        :status => "success",
        :token => user.authentication_token
      }
    else
      render_failure("Unknown user")
    end
  end

  protected

  def render_failure(message)
    render :json => {:status => "failure", :reason => message}
  end

  def validate_request
    check = params.clone
    check.delete(:controller)
    check.delete(:action)

    signature = check.delete(:signature)

    # Get the list of keys in alphabetical order
    keys = check.keys.sort

    # Pull together all params without delimiters
    query = keys.map { |key| [key, check[key]] }.flatten.join("")

    # Append this guild's api key
    query += Guild.current.api_key

    # Hash it up
    hash = Digest::MD5.hexdigest(query)

    # Check to see that the hash we found and the signature match
    if hash != signature
      render_failure("Hash didn't match")
    end
  end
end

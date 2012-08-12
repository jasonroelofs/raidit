require 'repository'
require 'models/user'

class UpdateUser

  def initialize(current_user)
    @current_user = current_user
  end

  def run(params)
    @current_user.login = params[:login] if params[:login].present?
    @current_user.email = params[:email] if params[:email].present?

    Repository.for(User).save(@current_user)
  end
end

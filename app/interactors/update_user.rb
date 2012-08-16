require 'repository'
require 'models/user'

class UpdateUser

  def initialize(current_user)
    @current_user = current_user
  end

  def run(params)
    @current_user.login = params[:login] if params[:login].present?
    @current_user.email = params[:email] if params[:email].present?

    if params[:current_password].present? &&
      params[:new_password].present? &&
      params[:confirm_new_password].present?

      if @current_user.password == params[:current_password] &&
        params[:new_password] == params[:confirm_new_password]

        @current_user.password = params[:new_password]
      else
        return false
      end
    end

    Repository.for(User).save(@current_user)
    true
  end
end

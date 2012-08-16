require 'repository'
require 'models/user'

class UpdateUser

  def initialize(current_user)
    @current_user = current_user
  end

  def run(params)
    @current_user.login = params[:login] if params[:login].present?
    @current_user.email = params[:email] if params[:email].present?

    if password_change_requested?(params)
      if current_password_matches?(params) &&
        new_passwords_match?(params)
        @current_user.password = params[:new_password]
      else
        return false
      end
    end

    Repository.for(User).save(@current_user)
    true
  end

  protected

  def password_change_requested?(params)
    params[:current_password].present? &&
      params[:new_password].present? &&
      params[:confirm_new_password].present?
  end

  def current_password_matches?(params)
    @current_user.password == params[:current_password]
  end

  def new_passwords_match?(params)
    params[:new_password] == params[:confirm_new_password]
  end
end

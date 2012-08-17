require 'repository'
require 'models/user'
require 'interactors/change_password'

class UpdateUser

  def initialize(current_user)
    @current_user = current_user
  end

  def user
    @current_user
  end

  ##
  # Hmm, hash params, not my favorite.
  # Values of hash can be:
  #
  #  :login
  #  :email
  #  :current_password
  #  :new_password
  #  :confirm_new_password
  #
  # If all three password fields are present then it's assumed
  # the user wants the password changed, so we change it if we can.
  #
  # Should this object know about changing the password or should
  # the use of ChangePassword be pulled out to the controller?
  ##
  def run(params)
    @current_user.login = params[:login] if params[:login].present?
    @current_user.email = params[:email] if params[:email].present?

    if password_change_requested?(params)
      action = ChangePassword.new(@current_user)
      action.run(*explode_password_params(params))
      @current_user = action.user
    end

    Repository.for(User).save(@current_user)
  end

  protected

  def password_change_requested?(params)
    params[:current_password].present? &&
      params[:new_password].present? &&
      params[:confirm_new_password].present?
  end

  def explode_password_params(params)
    params.values_at :current_password, :new_password, :confirm_new_password
  end

end

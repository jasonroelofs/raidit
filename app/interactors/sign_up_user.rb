require 'repository'
require 'models/user'

class SignUpUser

  attr_reader :user

  def run(user_params)
    @user = User.new :login => user_params[:login],
      :email => user_params[:email],
      :password => user_params[:password].presence

    if @user.valid?
      if @user.password != user_params[:password_confirmation].presence
        @user.errors.add(:password, "does not match confirmation")
        false
      else
        Repository.for(User).save user
      end
    else
      false
    end
  end

end

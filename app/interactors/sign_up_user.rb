require 'repository'
require 'models/user'

class SignUpUser

  attr_reader :user

  def run(attributes)
    @user = User.new :login => attributes[:login],
      :email => attributes[:email],
      :password => attributes[:password].presence

    if @user.valid?
      if @user.password != attributes[:password_confirmation].presence
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

require 'models/user'
require 'repository'

class RegisterUser

  attr_accessor :email, :password, :password_confirmation

  def run
    raise "Email is required" unless @email
    raise "Password is required" unless @password
    if @password != @password_confirmation
      raise "Password does not match confirmation"
    end

    user = User.new email: @email
    Repository.for(User).save user
  end
end
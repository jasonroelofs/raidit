require 'models/user'
require 'repositories/user_repository'

class RegisterUser

  attr_accessor :email, :password, :password_confirmation

  def run
    raise "Email is required" unless @email
    raise "Password is required" unless @password
    if @password != @password_confirmation
      raise "Password does not match confirmation"
    end

    user = User.new email: @email
    UserRepository.save user
  end
end
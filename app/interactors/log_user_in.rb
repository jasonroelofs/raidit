require 'securerandom'

require 'models/user'
require 'interactors/find_user'
require 'repository'

class LogUserIn

  attr_reader :login_type

  def initialize(login_type)
    @login_type = login_type
  end

  def run(login, password)
    action = FindUser.new
    user = action.by_login login
    if user && user.password == password
      user.set_login_token @login_type, new_login_token
      user
    else
      nil
    end
  end

  protected

  def new_login_token
    SecureRandom.hex(32)
  end
end

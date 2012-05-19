class User

  attr_reader :email, :login, :password

  def initialize(attrs = {})
    @email = attrs[:email]
    @login = attrs[:login]
    @password = attrs[:password]
    @login_tokens = {}
  end

  def set_login_token(type, token)
    @login_tokens[type] = token
  end

  def login_token(type)
    @login_tokens[type]
  end

end
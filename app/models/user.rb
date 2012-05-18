class User

  attr_reader :email

  def initialize(attrs = {})
    @email = attrs[:email]
    @login_tokens = {}
  end

  def set_login_token(type, token)
    @login_tokens[type] = token
  end

  def login_token(type)
    @login_tokens[type]
  end

end
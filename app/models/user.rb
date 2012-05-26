class User

  attr_reader :email, :login, :password

  def initialize(attrs = {})
    @email = attrs[:email]
    @login = attrs[:login]
    @password = attrs[:password]
    @login_tokens = {}
    @onboarding = Hash.new true
  end

  def set_login_token(type, token)
    @login_tokens[type] = token
  end

  def login_token(type)
    @login_tokens[type]
  end

  def set_onboarding_flag(flag, value)
    @onboarding[flag] = value
  end

  def onboarding_value(flag)
    @onboarding[flag]
  end

end
require 'entity'

class User
  include Entity

  attr_accessor :email, :login, :password

  def initialize(attrs = {})
    super

    @login_tokens = {}
    @onboarding = {}
  end

  def set_login_token(type, token)
    @login_tokens[type] = token
  end

  def login_token(type)
    @login_tokens[type]
  end

  def onboarded!(flag)
    @onboarding[flag] = true
  end

  def requires_onboarding?(flag)
    @onboarding[flag].nil?
  end

end

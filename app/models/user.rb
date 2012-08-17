require 'entity'
require 'bcrypt'

class User
  include Entity

  # Due to how insanely slow bcrypt is, I don't want it running
  # continuously through the test suite, so I flag it accordingly.
  cattr_accessor :bcrypt_enabled
  @@bcrypt_enabled = true

  attr_accessor :email, :login

  attr_reader :password_hash

  def initialize(attrs = {})
    super

    @login_tokens = {}
    @onboarding = {}
  end

  ##
  # Setting a new password, gets hashed via bcrypt
  ##
  def password=(new_password)
    if self.class.bcrypt_enabled
      @password = nil
      @password_hash = BCrypt::Password.create new_password
    else
      @password = new_password
    end
  end

  ##
  # Return a comparison object that can be used to check
  # if two passwords match, ignoring the hashing
  ##
  def password
    if self.class.bcrypt_enabled
      @password ||= BCrypt::Password.new(@password_hash)
    else
      @password
    end
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

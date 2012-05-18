class User

  attr_reader :email

  attr_accessor :web_session_token

  def initialize(attrs = {})
    @email = attrs[:email]
  end
end
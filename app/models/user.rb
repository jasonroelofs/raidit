class User

  attr_reader :email

  def initialize(attrs = {})
    @email = attrs[:email]
  end
end
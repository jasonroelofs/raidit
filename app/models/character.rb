class Character

  attr_reader :name, :user

  def initialize(attrs = {})
    @name = attrs[:name]
    @user = attrs[:user]
  end
end
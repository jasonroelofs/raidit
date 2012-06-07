class Character

  attr_reader :name, :user, :game, :server, :region

  def initialize(attrs = {})
    @name = attrs[:name]
    @user = attrs[:user]
    @game = attrs[:game]
    @server = attrs[:server]
    @region = attrs[:region]
  end
end
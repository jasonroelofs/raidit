require 'entity'

class Character
  include Entity

  attr_accessor :user

  attr_accessor :name, :game, :server, :region

end

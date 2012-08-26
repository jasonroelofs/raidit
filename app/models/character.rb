require 'entity'

class Character
  include Entity

  attr_accessor :user, :guild

  attr_accessor :name, :game, :server, :region, :character_class, :is_main

  def main?
    !!@is_main
  end

end

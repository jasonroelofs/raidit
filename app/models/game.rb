class Game

  # Full name of the game
  attr_reader :name

  # Short, unique string for the game
  attr_reader :slug

  def initialize(name, slug)
    @name = name
    @slug = slug
  end

end
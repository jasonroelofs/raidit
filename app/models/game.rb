class Game

  def self.by_short_name(short_name)
    GAMES[short_name].new
  end

  def character_classes
    raise "Implement in Game subclass"
  end

  class WoW < Game
    CHARACTER_CLASSES = [
      "Death Knight",
      "Druid",
      "Hunter",
      "Mage",
      "Monk",
      "Paladin",
      "Priest",
      "Rogue",
      "Shaman",
      "Warlock",
      "Warrior"
    ]

    def character_classes
      CHARACTER_CLASSES
    end
  end

  GAMES = {
    "wow" => Game::WoW
  }

end

module CharactersHelper
  def character_classes_for_game(game)
    Game.by_short_name(game).character_classes.map {|klass|
      [klass, normalize_name(klass), {"data-character-class" => normalize_name(klass)}]
    }
  end

  def character_icon(character, icon_size = :medium)
    if character.character_class.present?
      image_tag ["wow", normalize_name(character.character_class)].join("/") + ".png",
        :class => "class-icon class-icon-#{icon_size}"
    end
  end

  def sorted_characters_main_first(characters)
    characters.sort do |c1, c2|
      if c1.main?
        -1
      elsif c2.main?
        1
      else
        c1.name <=> c2.name
      end
    end
  end
end

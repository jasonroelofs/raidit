module CharactersHelper
  def character_icon(character)
    if character.character_class.present?
      image_tag ["wow", normalize_name(character.character_class)].join("/") + ".png"
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

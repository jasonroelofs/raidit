module CharactersHelper
  def character_icon(character)
    if character.game.present? && character.character_class.present?
      image_tag [character.game, normalize_name(character.character_class)].join("/") + ".png"
    end
  end
end

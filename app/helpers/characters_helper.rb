module CharactersHelper
  def character_icon(character)
    if character.game.present? && character.character_class.present?
      image_tag [character.game, normalize(character.character_class)].join("/") + ".png"
    end
  end

  protected

  def normalize(character_class)
    character_class.underscore.gsub(/[_\s]/, '')
  end
end

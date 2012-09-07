require 'models/character'
require 'repository'

class AddCharacter

  attr_reader :current_user

  def initialize(current_user)
    @current_user = current_user
  end

  ##
  # Given the current_user, add a Character to this user
  ##
  def run(name, character_class)
    character = Character.new name: name, user: @current_user, character_class: character_class
    Repository.for(Character).save character
  end
end

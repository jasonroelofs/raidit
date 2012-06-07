require 'models/character'
require 'repository'

class AddCharacter

  attr_reader :current_user

  def initialize(current_user)
    @current_user = current_user
  end

  ##
  # Given the current_user, add a Character to this user
  # with the given game information.
  # TODO: params here are a bit too wow-ish. May need to build a
  # character-description object to pass in instead.
  ##
  def run(game, region, server, name)
    character = Character.new game: game, region: region, server: server,
      name: name, user: @current_user

    Repository.for(Character).save character
  end
end
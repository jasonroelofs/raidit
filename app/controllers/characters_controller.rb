class CharactersController < ApplicationController

  requires_user

  def index
    action = ListCharacters.new current_user
    @characters = action.run
  end

end

class CharactersController < ApplicationController

  # List all characters for the current user
  # in the current guild
  def index
  end

  # Show the user the list of all unselected characters
  # in the current guild and select which one to
  # add to that user's list
  def new
    @characters = current_guild.characters.unchosen
  end

  # Given an id of a charcter, associate that character
  # with the current logged in user
  def associate
    character = current_guild.characters.find(params[:id])
    character.user = current_user
    character.save

    redirect_to(characters_path) 
  end
end

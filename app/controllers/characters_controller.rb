class CharactersController < ApplicationController

  before_filter :authenticate_user!

  # List all characters for the current user
  # in the current guild
  def index
    @characters = current_user.characters_in(current_guild)
  end

  # Page for users to find and assign characters to their account
  def new
  end

  # Look for characters according to name given
  def search
    @characters = current_guild.characters.unchosen.where(:name => /#{params[:name]}/i).all
    render :layout => nil
  end

  # Update this character.
  def update
    c = current_user.characters.find(params[:id])
    c.update_attributes(params[:character])

    redirect_to(characters_path)
  end

  # Make a given character your main
  def make_main
    current_user.change_main_to!(params[:id])

    redirect_to(characters_path) 
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

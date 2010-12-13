class CharactersController < ApplicationController

  before_filter :authenticate_user!

  requires_permission :admin, :only => [:unassociate]

  # List all characters for the current user
  # in the current guild
  def index
    @characters = current_user.characters_in(current_guild)

    if @characters.any?
      # Fix main if one isn't set
      c = @characters.first

      if !c.is_main
        c.is_main = true
        c.save
        c.reload
      end
    end
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

  # Remove the user association from this character
  def unassociate
    character = current_guild.characters.find(params[:id])
    old_user_id = character.user.id

    character.is_main = false
    character.user = nil

    character.save

    flash[:notice] = "Character #{character.name} was unassociated"

    redirect_to(admin_edit_user_path(old_user_id)) 
  end
end

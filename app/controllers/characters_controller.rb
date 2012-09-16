class CharactersController < ApplicationController

  requires_user
  navigation :characters

  def index
    action = ListCharacters.new current_user
    @characters_by_guild = action.all_grouped_by_guild

    if @characters_by_guild.empty?
      redirect_to action: "new"
    end
  end

  def new
    @character = Character.new
  end

  def create
    action = AddCharacter.new current_user
    if action.run params[:character]
      redirect_to action: "index"
    else
      @character = action.character
      render "new"
    end
  end

  def edit
    @character = find_character params[:id].to_i
  end

  def update
    @character = find_character params[:id].to_i
    action = UpdateCharacter.new @character
    if action.run params[:character]
      redirect_to action: "index"
    else
      @character = action.current_character
      render "edit"
    end
  end

  def make_main
    character = find_character params[:id].to_i
    SelectMainCharacter.run character

    redirect_to action: "index"
  end

  protected

  def find_character(character_id)
    action = FindCharacter.new current_user
    action.by_id character_id
  end
end

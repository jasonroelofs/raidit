class CharactersController < ApplicationController

  requires_user
  navigation :characters

  def index
    action = ListCharacters.new current_user
    @guilded_characters = action.guilded
    @unguilded_characters = action.unguilded

    if @guilded_characters.empty? && @unguilded_characters.empty?
      redirect_to action: "new"
    end
  end

  def new
    @current_guilds = ListGuilds.by_user current_user
  end

  def create
    action = AddCharacter.new current_user
    action.run params[:name], params[:character_class], params[:guild_id].try(:to_i)

    redirect_to action: "index"
  end

  def edit
    @character = FindCharacter.by_id params[:id].to_i
  end

  def update
    @character = FindCharacter.by_id params[:id].to_i
    action = UpdateCharacter.new @character
    if action.run params[:character]
      redirect_to action: "index"
    else
      @character = action.current_character
      render "edit"
    end
  end

  def make_main
    character = FindCharacter.by_id params[:id].to_i
    SelectMainCharacter.run character

    redirect_to action: "index"
  end
end

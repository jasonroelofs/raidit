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
  end

  def create
    action = AddCharacter.new current_user
    action.run(
      params[:game],
      params[:region],
      params[:server],
      params[:name]
    )

    redirect_to action: "index"
  end

end

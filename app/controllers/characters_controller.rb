class CharactersController < ApplicationController

  requires_user

  def index
    action = ListCharacters.new current_user
    @characters = action.run

    if @characters.empty?
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

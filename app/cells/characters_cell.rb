class CharactersCell < Cell::Rails

  # List all characters for the current user
  # for the current guild
  def list
    @characters = User.current.characters_in(Guild.current)
    render
  end

  # Render details for an individual character
  def show
    @character = @opts[:character]
    render
  end

end

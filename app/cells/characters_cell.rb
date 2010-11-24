class CharactersCell < Cell::Rails

  # Render details for an individual character
  def show
    @character = @opts[:character]
    @name_url = @opts[:name_url]
    render
  end

  # Special rendering of a character that's used when
  # looking at a raid's queues
  def in_raid
    @character = @opts[:character]
    @queue = @opts[:queue]

    # up button: none, queue, accept
    # down button: queue, cancel, none

    render
  end

end

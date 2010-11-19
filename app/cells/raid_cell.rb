class RaidCell < Cell::Rails

  # Render the queue view for the given raid
  # and the given queue
  def queue
    @queue = @opts[:queue]
    @raid = @opts[:raid]

    @characters = Character.all[0..20]

    render
  end
end

class RaidCell < Cell::Rails

  # Render the queue view for the given raid
  # and the given queue
  def queue
    @queue = @opts[:queue]
    @raid = @opts[:raid]

    @accepted = @raid.accepted.characters
    @queued = @raid.queued.characters
    @cancelled = @raid.cancelled.characters

    render
  end
end

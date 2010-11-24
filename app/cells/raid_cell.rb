class RaidCell < Cell::Rails

  # Render the queue view for the given raid
  # and the given queue
  def queue
    @role = @opts[:role]
    @raid = @opts[:raid]

    @accepted = @raid.accepted.characters_for(@role)
    @queued = @raid.queued.characters_for(@role)
    @cancelled = @raid.cancelled.characters_for(@role)

    render
  end
end

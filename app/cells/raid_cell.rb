class RaidCell < Cell::Rails
  helper RaidsHelper
  helper RolesHelper

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

  # Render the actions the current user can 
  # take on the given character in the given queue
end

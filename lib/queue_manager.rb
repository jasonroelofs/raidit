# This class handles all the logic behind moving characters 
# in queues, whether accepting, rejecting, cancelling, re-queueing, or 
# changing roles, this class will handle it.
class QueueManager

  # Process the requested action for the given raid, queue and character
  def self.process(action, raid, role, character)
    new(action, raid, role, character).run
  end

  # State machine definition
  #
  # Actions: 
  #   accept [RL]   (queued => accepted)
  #   cancel [User] (accepted => cancelled) | (queued => cancelled)
  #   queue  [User] (cancelled => queued) | [RL] (accepted => queued)
  #
  # This sets itself to the current state of the character in the queue
  # then runs the action requested and lets the state machine decide on
  # if the action is allowed or not.
  #
  state_machine :state do

    # Awaiting acceptance
    state :queued

    # Been chosen by a raid leader to come to the raid
    state :accepted

    # Cancelled by the user for whatever reason
    state :cancelled

    # Raid Leader wants to accept a character from queued
    event :accept do
      transition :queued => :accepted, :if => :is_raid_leader?
    end

    after_transition :on => :accept do |obj|
      obj.raid.mark_event!("accepted #{obj.character.name} as #{obj.role}")
    end

    # User wants to cancel a queueing
    event :cancel do
      transition [:accepted, :queued] => :cancelled, :if => :is_owner_of_character?
    end

    after_transition :on => :cancel do |obj|
      obj.raid.mark_event!("cancelled #{obj.character.name} as #{obj.role}")
    end

    # Raid leader wants to un-accept someone
    event :queue do
      transition :accepted => :queued, :if => :is_raid_leader?
      transition :cancelled => :queued, :if => :is_owner_of_character?
    end

    after_transition :on => :queue do |obj|
      obj.raid.mark_event!("re-queued #{obj.character.name} as #{obj.role}")
    end
  end

  attr_accessor :character, :role, :raid

  def initialize(action, raid, role, character)
    @action = action
    @raid = raid
    @role = role
    @character = character
  end

  # Processes the action
  def run
    @state = @raid.current_character_queue(@role, @character).to_s
    from = @state

    if @state
      self.send(@action)
      @raid.move_character(@role, @character, from, @state)
    end
  end

  protected

  def is_raid_leader?
    User.current.has_role?(:raid_leader)
  end

  def is_owner_of_character?
    @character.user == User.current
  end
end

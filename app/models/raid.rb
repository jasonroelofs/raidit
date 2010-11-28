class Raid
  include MongoMapper::Document

  key :location,    String
  key :description, String

  # Mongo Mapper doesn't handle Dates or Times correctly at all
  # Save them as pure strings and do conversions ourself
  key :date,        String
  key :start_time,  String
  key :invite_time, String

  # Number of the given role we want
  # to have in this raid
  key :tanks, Integer
  key :dps, Integer
  key :healers, Integer

  key :accepted, RaidQueue, :default => RaidQueue.new(:name => "accepted")
  key :queued, RaidQueue, :default => RaidQueue.new(:name => "queued")
  key :cancelled, RaidQueue, :default => RaidQueue.new(:name => "cancelled")

  timestamps!

  attr_accessible :location, :description, :date, :start_time, :invite_time,
    :tanks, :dps, :healers

  # Get all raids that are scheduled for a given date
  scope :for, lambda {|date| 
    where(:date => date.to_s) 
  }

  # Is this raid still in the future?
  def upcoming?
    self.date >= Date.today
  end

  # Given a role, character and action, perform the action
  # if it's allowed
  #
  # Actions: 
  #   accept [RL]   (queued => accepted)
  #   cancel [User] (accepted => cancelled) | (queued => cancelled)
  #   queue  [User] (cancelled => queued) | [RL] (accepted => queued)
  def update_character_queue(role, action, character)
  end

  ##
  # Type conversions
  ##

  # Convert our date field to and from a Date object
  def date=(val)
    self["date"] = val.to_s if val
  end

  def date
    Date.parse(self["date"])
  end

  # Start time and Invite time can just be strings
end

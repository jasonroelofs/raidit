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

  # Find out which queue the character is currently in
  def current_character_queue(role, character)
    self.accepted.has_character?(character, role) ? :accepted :
      self.queued.has_character?(character, role) ? :queued :
        self.cancelled.has_character?(character, role) ? :cancelled : nil
  end

  # Move a character from one queue to another
  def move_character(role, character, from_queue, to_queue)
    self.send(from_queue).remove!(character, role)
    self.send(to_queue).add!(character, role)
    self.save
  end

  # How many characters have been accepted for the given role?
  def number_accepted_for(role)
    self.accepted.number_in_role(role)
  end

  # For the current user look to see if he/she has a character
  # in the given raid, and return what queue that character is in
  def status_of_current_user
    user = User.current
    status = nil

    user.characters.each do |char|
      if self.accepted.has_character_id?(char.id)
        status = "accepted"
      elsif self.queued.has_character_id?(char.id)
        status = "queued"
      elsif self.cancelled.has_character_id?(char.id)
        status = "cancelled"
      end

      break if status
    end

    status
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

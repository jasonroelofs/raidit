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

  timestamps!

  attr_accessible :location, :description, :date, :start_time, :invite_time

  # Get all raids that are scheduled for a given date
  scope :for, lambda {|date| 
    where(:date => date.to_s) 
  }

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

class Raid
  include MongoMapper::Document

  key :location,    String
  key :description, String
  key :date,        Date
  key :start_time,  Time
  key :invite_time, Time

  # Number of the given role we want
  # to have in this raid
  key :tanks, Integer
  key :dps, Integer
  key :healers, Integer

  timestamps!

  attr_accessible :location, :description, :date, :start_time, :invite_time

  # Get all raids that are scheduled for a given date
  scope :for, lambda {|date| 
    where(:date.gte => date.beginning_of_day, :date.lt => date.end_of_day) 
  }

end

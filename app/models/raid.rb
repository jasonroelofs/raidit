class Raid
  include MongoMapper::Document

  key :location,    String
  key :description, String
  key :date,        Date
  key :start_time,  Time
  key :invite_time, Time

  timestamps!

  # Get all raids that are scheduled for a given date
  scope :for, lambda {|date| 
    where(:date.gte => date.beginning_of_day, :date.lte => date.end_of_day) 
  }

end

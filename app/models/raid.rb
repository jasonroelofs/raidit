class Raid
  include MongoMapper::Document

  key :location,    String
  key :description, String
  key :date,        Date
  key :start_time,  Time
  key :invite_time, Time

  timestamps!

end

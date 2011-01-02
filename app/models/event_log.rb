class EventLog
  include MongoMapper::EmbeddedDocument

  # Name of whoever created this event
  key :who, String

  # String description of the event
  key :event, String

  # When event happened
  key :when, Time

end

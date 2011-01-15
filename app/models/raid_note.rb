# Collection of notes for this character, displayed for 
# a given raid
class RaidNote
  include MongoMapper::EmbeddedDocument

  key :raid_id, ObjectId
  belongs_to :raid

  # The text of the note itself
  key :note, String

  # String character name of who left the note
  key :by, String

  key :created_at, Time
end

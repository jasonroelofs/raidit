# Collection of notes for this character, displayed for 
# a given raid
class RaidNote
  include MongoMapper::EmbeddedDocument

  key :character_id
  key :raid_id

  belongs_to :character
  belongs_to :raid

  # The text of the note itself
  key :note

  # String character name of who left the note
  key :by
end

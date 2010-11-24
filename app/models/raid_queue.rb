# Define a queue for a raid.
# Queues are embedded in raids
class RaidQueue
  include MongoMapper::EmbeddedDocument

  key :name, String
  key :character_ids, Array

  # Get all characters in this queue
  def characters
    Guild.current.characters.find(self.character_ids)
  end
end

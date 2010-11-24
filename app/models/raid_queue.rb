# Define a queue for a raid.
# Queues are embedded in raids
class RaidQueue
  include MongoMapper::EmbeddedDocument

  # One of 'accepted', 'cancelled', or 'queued'
  key :name, String

  # Hash of role => [character ids]
  key :roles, Hash

  # Get all characters in this queue for the given role
  def characters_for(role)
    Guild.current.characters.find(self.roles[role.to_s] || [])
  end

  # Add a character to this queue
  def add!(character, role)
    self.roles[role.to_s] ||= []
    self.roles[role.to_s] << character.id
    self.roles[role.to_s].uniq!

    self.save
  end
end

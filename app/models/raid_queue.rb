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

  # Does this queue have the requested character in the given role?
  def has_character?(character, role)
    character ? (self.roles[role.to_s] || []).include?(character.id) : false
  end

  # Removes the character from the given role
  def remove!(character, role)
    self.roles[role.to_s].delete(character.id)
    self.save
  end

  # Add a character to this queue
  def add!(character, role)
    self.roles[role.to_s] ||= []
    self.roles[role.to_s] << character.id
    self.roles[role.to_s].uniq!

    self.save
  end
end

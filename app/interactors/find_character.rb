require 'repository'
require 'models/character'

# TODO FIXME Not checking permissions on if the current user is allowed
# to even see this character.

class FindCharacter

  def self.by_id(id)
    Repository.for(Character).find(id)
  end

end

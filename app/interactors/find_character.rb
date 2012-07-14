require 'repository'
require 'models/character'

class FindCharacter

  def self.by_id(id)
    Repository.for(Character).find(id)
  end

end

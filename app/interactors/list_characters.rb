require 'repository'
require 'models/character'

class ListCharacters

  def self.all_for_user(user)
    Repository.for(Character).find_all_for_user user
  end

end

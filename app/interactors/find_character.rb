require 'repository'
require 'models/character'

class FindCharacter

  def initialize(current_user)
    @current_user = current_user
  end

  def by_id(id)
    Repository.for(Character).find_by_user_and_id(@current_user, id)
  end

end

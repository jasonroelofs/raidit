require 'repository'
require 'models/character'

class ListCharacters

  attr_accessor :user

  def initialize(user)
    @user = user
  end

  def run
    Repository.for(Character).find_all_for_user @user
  end

end

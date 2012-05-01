require 'repository'
require 'models/character'

class ListCharacters

  attr_accessor :user

  def run
    raise "User required" unless @user

    Repository.for(Character).find_all_for_user @user
  end

end
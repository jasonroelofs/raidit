require 'repository'
require 'models/character'

class ListCharacters

  def self.all_for_user(user)
    Repository.for(Character).find_all_for_user user
  end

  def self.all_in_guild(guild)
    Repository.for(Character).find_all_in_guild(guild)
  end

  def self.for_user_in_guild(user, guild)
    Repository.for(Character).find_all_for_user_in_guild(user, guild).sort do |c1, c2|
      # Sort block duplicated in a helper. Push sorting down lower in the stack?
      if c1.main?
        -1
      elsif c2.main?
        1
      else
        c1.name <=> c2.name
      end
    end
  end

end

require 'repository'

class FindGuild

  def by_id(id)
    Repository.for(Guild).find id
  end

  def by_name(name)
    Repository.for(Guild).find_by_name name
  end

end
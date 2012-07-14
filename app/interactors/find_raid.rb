require 'repository'
require 'models/raid'

class FindRaid

  def self.by_id(id)
    Repository.for(Raid).find(id)
  end

end

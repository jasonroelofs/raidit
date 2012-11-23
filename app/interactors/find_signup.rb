require 'repository'
require 'models/signup'

class FindSignup
  def self.by_id(id)
    Repository.for(Signup).find(id)
  end

  def self.by_raid_and_id(raid, id)
    Repository.for(Signup).find_by_raid_and_id(raid, id)
  end
end

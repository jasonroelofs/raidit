require 'repository'
require 'models/signup'

class FindSignup
  def self.by_id(id)
    Repository.for(Signup).find(id)
  end
end

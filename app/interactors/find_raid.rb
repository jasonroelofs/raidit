require 'repository'
require 'models/raid'

##
# NOTE: Is this too simple for an Interactor?
##
class FindRaid

  def by_id(id)
    Repository.for(Raid).find(id)
  end

end

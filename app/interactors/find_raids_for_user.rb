##
# Returns the full list of raids that given user is allowed to see.
##
class FindRaidsForUser

  attr_reader :current_user

  def initialize(current_user)
    @current_user = current_user
  end

  def run
    Repository.for(Raid).find_raids_for_user(@current_user).sort {|r1, r2|
      r2.when <=> r1.when
    }
  end
end
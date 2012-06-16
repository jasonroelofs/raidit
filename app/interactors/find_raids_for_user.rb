##
# Returns the full list of raids that given user is allowed to see.
##
class FindRaidsForUser

  attr_reader :current_user

  def initialize(current_user)
    @current_user = current_user
  end

  def run(day = nil)
    Repository.for(Raid).find_raids_for_user_and_day(@current_user, day).
      sort {|r1, r2| r2.when <=> r1.when }
  end
end
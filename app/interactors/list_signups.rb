require 'repository'
require 'models/signup'

class ListSignups

  def for_raid(raid)
    signups = find_signups_for_raid(raid)
    group_signups_by_status(signups)
  end

  protected

  def find_signups_for_raid(raid)
    Repository.for(Signup).find_all_for_raid(raid)
  end

  def group_signups_by_status(signups)
    signup_groups = SignupGroups.new

    signups.each do |signup|
      signup_groups.add_signup signup
    end

    signup_groups
  end

  public

  class SignupGroups
    def initialize
      @groups = {
        accepted:  [],
        available: [],
        cancelled: []
      }
    end

    def add_signup(signup)
      @groups[signup.acceptance_status.to_sym] << signup
    end

    def accepted
      @groups[:accepted]
    end

    def available
      @groups[:available]
    end

    def cancelled
      @groups[:cancelled]
    end

    def contains?(character)
      @groups.each do |group, list|
        list.each do |signup|
          return true if signup.character == character
        end
      end

      false
    end
  end

end

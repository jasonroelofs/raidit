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
    signup_groups = {
      :accepted => [],
      :available => [],
      :cancelled => []
    }

    signups.each do |signup|
      signup_groups[signup.acceptance_status] << signup
    end

    signup_groups
  end

end

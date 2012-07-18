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
        accepted:  {},
        available: {},
        cancelled: {}
      }
    end

    def add_signup(signup)
      @groups[signup.acceptance_status.to_sym] ||= {}
      @groups[signup.acceptance_status.to_sym][signup.role] ||= []
      @groups[signup.acceptance_status.to_sym][signup.role] << signup
    end

    def accepted(role)
      @groups[:accepted][role] || []
    end

    def available(role)
      @groups[:available][role] || []
    end

    def cancelled(role)
      @groups[:cancelled][role] || []
    end

    def contains?(character)
      @groups.each do |group, role|
        role.each do |role, list|
          list.each do |signup|
            return true if signup.character == character
          end
        end
      end

      false
    end
  end

end

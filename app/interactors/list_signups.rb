require 'repository'
require 'models/signup'

class ListSignups

  def self.for_raid_and_user(raid, user)
    Repository.for(Signup).find_all_for_user_and_raid(user, raid)
  end

  def self.for_raid(raid)
    new.for_raid(raid)
  end

  def for_raid(raid)
    signups = find_signups_for_raid(raid)
    group_signups_by_status(signups)
  end

  protected

  def find_signups_for_raid(raid)
    Repository.for(Signup).find_all_for_raid(raid)
  end

  def group_signups_by_status(signups)
    signup_groups = Signups.new

    signups.each do |signup|
      signup_groups.add_signup signup
    end

    signup_groups
  end

  public

  class Signups
    def initialize
      @groups = {
        accepted:  SignupGroup.new,
        available: SignupGroup.new,
        cancelled: SignupGroup.new
      }
    end

    def add_signup(signup)
      @groups[signup.acceptance_status.to_sym].add(signup)
    end

    def accepted(role)
      @groups[:accepted].signups_in(role)
    end

    def available(role)
      @groups[:available].signups_in(role)
    end

    def cancelled(role)
      @groups[:cancelled].signups_in(role)
    end

    def contains?(character)
      @groups.each do |key, groups|
        if groups.contains?(character)
          return true
        end
      end

      false
    end

    class SignupGroup
      def initialize
        @groups = Hash.new {|hash, key| hash[key] = [] }
      end

      def add(signup)
        @groups[signup.role] << signup
      end

      def signups_in(role)
        @groups[role]
      end

      def contains?(character)
        @groups.values.flatten.each do |signup|
          return true if signup.character == character
        end

        false
      end
    end
  end

end

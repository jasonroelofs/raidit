module ActiveRecordRepo::Models
  class Signup < ActiveRecord::Base
    # Oh this is dirty! Force this to be a symbol...
    serialize :acceptance_status

    belongs_to :raid
    belongs_to :user
    belongs_to :character

    def self.for_raid(raid)
      where(:raid_id => raid.id)
    end

    def self.for_user_and_raid(user, raid)
      for_raid(raid).where(:user_id => user.id)
    end

    def self.first_by_id_and_raid(id, raid)
      for_raid(raid).where(:id => id).first
    end
  end
end

module ActiveRecordRepo::Models
  class Permission < ActiveRecord::Base
    serialize :permissions

    belongs_to :user
    belongs_to :guild

    def self.first_by_user_and_guild(user, guild)
      where(:user_id => user.id, :guild_id => guild.id).first
    end
  end
end

module ActiveRecordRepo::Models
  class Character < ActiveRecord::Base
    belongs_to :user
    belongs_to :guild

    def self.for_user(user)
      where(:user_id => user.id)
    end

    def self.in_guild(guild)
      where(:guild_id => guild.id)
    end

    def self.for_user_in_guild(user, guild)
      for_user(user).in_guild(guild)
    end

    def self.first_by_user_and_id(user, id)
      for_user(user).where(:id => id).first
    end

    def self.user_main_in_guild(user, guild)
      for_user_in_guild(user, guild).where(:is_main => true).first
    end
  end
end

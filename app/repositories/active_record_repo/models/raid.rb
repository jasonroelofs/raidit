module ActiveRecordRepo::Models
  class Raid < ActiveRecord::Base
    serialize :role_limits, ActiveRecord::Coders::Hstore

    belongs_to :owner, :class_name => "ActiveRecordRepo::Models::Guild"

    def self.for_guild(guild)
      where(:owner_id => guild.id)
    end

    def self.for_guild_and_day(guild, day)
      for_guild(guild).where(["DATE(raids.when) = ?", day.to_date])
    end
  end
end

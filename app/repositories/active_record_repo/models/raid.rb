module ActiveRecordRepo::Models
  class Raid < ActiveRecord::Base
    serialize :role_limits, ActiveRecord::Coders::Hstore
    after_initialize :convert_role_limits

    belongs_to :owner, :class_name => "ActiveRecordRepo::Models::Guild"

    def self.for_guild(guild)
      where(:owner_id => guild.id)
    end

    def self.for_guild_and_day(guild, day)
      for_guild(guild).where(["DATE(raids.when) = ?", day.to_date])
    end

    protected

    def convert_role_limits
      # Ensure all keys are symbols, and all values are integers
      self.role_limits = Hash[*role_limits.map {|k,v| [k.to_sym, v.to_i] }.flatten] if role_limits
    end
  end
end

require 'entity'

class Permission
  include Entity

  RAID_LEADER = [
    :manage_signups,
    :schedule_raid,
    :manage_guild_members
  ].freeze
  ALL_PERMISSIONS = RAID_LEADER

  FRIENDLY_NAMES = {
    :manage_signups => "Manage Signups",
    :schedule_raid => "Schedule Raids",
    :manage_guild_members => "Manage Guild Members"
  }.freeze

  def self.friendly_name(permission)
    FRIENDLY_NAMES[permission]
  end


  attr_accessor :user, :guild, :permissions

  def initialize(*)
    super
    @permissions ||= []
  end

  def allow(perm)
    (@permissions << perm).uniq!
  end

  def allows?(perm)
    @permissions.include?(perm)
  end

end

require 'entity'

class Permission
  include Entity

  RAID_LEADER = [
    :manage_signups,
    :schedule_raid
  ].freeze

  GUILD_LEADER = [
    RAID_LEADER,
    :manage_guild_members
  ].flatten.freeze

  ALL_PERMISSIONS = GUILD_LEADER

  FRIENDLY_NAMES = {
    :manage_signups => "Manage Signups",
    :schedule_raid => "Schedule Raids",
    :manage_guild_members => "Manage Guild Members"
  }.freeze

  def self.friendly_name(permission)
    FRIENDLY_NAMES[permission]
  end

  def self.empty(user, guild)
    Permission.new(:user => user, :guild => guild)
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

  def reset!
    @permissions = []
  end

  def empty?
    @permissions.empty?
  end
end

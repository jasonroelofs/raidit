require 'entity'

class Permission
  include Entity

  RAID_LEADER = [:manage_signups, :schedule_raid].freeze
  ALL_PERMISSIONS = RAID_LEADER

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

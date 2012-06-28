require 'models/raid'
require 'repository'

##
# Create a new raid schedule or update an existing one.
# The raid will be owned and led by the given +current_user+.
#
# A raid needs a location (+where+), a date (+raid_date+),
# a start time (+raid_time+) and optionally a hash of +roles+
# to define the types of characters needed in this raid.
#
# The start time for a raid by default is 15 minutes before the
# start time. This will eventually be configurable.
#
# To update an existing raid with new information, use
# +current_raid=+ to set that raid.
##
class ScheduleRaid

  DEFAULT_INVITE_WINDOW = 15 * 60

  attr_accessor :current_user, :current_guild

  ##
  # Use this value to update an existing Raid instead of
  # creating a new one.
  ##
  attr_accessor :current_raid

  def initialize(current_user, current_guild = nil)
    @current_user = current_user
    @current_guild = current_guild
  end

  def run(where, raid_date, raid_time, roles = nil)
    raid = @current_raid || Raid.new

    raid.where      = where
    raid.when       = raid_date
    raid.start_at   = raid_time
    raid.invite_at  = raid_time - DEFAULT_INVITE_WINDOW

    raid.leader     = @current_user
    raid.owner      = @current_user

    if roles
      roles.each do |role, limit|
        raid.set_role_limit(role, limit)
      end
    end

    Repository.for(Raid).save raid
  end

end

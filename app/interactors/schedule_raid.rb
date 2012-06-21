require 'models/raid'
require 'repository'

class ScheduleRaid

  DEFAULT_INVITE_WINDOW = 15 * 60

  attr_accessor :current_user, :current_guild

  def initialize(current_user, current_guild = nil)
    @current_user = current_user
    @current_guild = current_guild
  end

  def run(where, raid_date, raid_time, roles = nil)
    raid = Raid.new where: where, when: raid_date, start_at: raid_time,
      invite_at: raid_time - DEFAULT_INVITE_WINDOW,
      leader: @current_user, owner: @current_user

    if roles
      roles.each do |role, limit|
        raid.set_role_limit(role, limit)
      end
    end

    Repository.for(Raid).save raid
  end

end

require 'models/raid'
require 'repository'

class ScheduleRaid

  attr_accessor :current_user, :current_guild

  def initialize(current_user, current_guild = nil)
    @current_user = current_user
    @current_guild = current_guild
  end

  def run(raid_time)
    raid = Raid.new when: raid_time, leader: @current_user
    Repository.for(Raid).save raid
  end

end
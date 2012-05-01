require 'models/raid'
require 'repository'

class CreateRaid

  attr_accessor :when, :leader, :guild

  def run
    raise "Leader is required" unless @leader
    raise "Date / Time is required" unless @when

    raid = Raid.new when: @when, leader: @leader
    Repository.for(Raid).save raid
  end

end
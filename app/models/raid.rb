class Raid

  attr_reader :id, :when, :leader, :owner, :where

  attr_reader :start_at, :invite_at

  attr_accessor :groups

  def initialize(attrs = {})
    @id = attrs[:id]
    @when = attrs[:when]
    @leader = attrs[:leader]
    @owner = attrs[:owner]
    @where = attrs[:where]
    @start_at = attrs[:start_at]
    @invite_at = attrs[:invite_at]
    @groups = attrs[:groups] || []
  end
end
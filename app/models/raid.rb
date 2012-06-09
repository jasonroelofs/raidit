class Raid

  attr_reader :id, :when, :leader, :owner

  attr_accessor :groups

  def initialize(attrs = {})
    @id = attrs[:id]
    @when = attrs[:when]
    @leader = attrs[:leader]
    @owner = attrs[:owner]
    @groups = attrs[:groups] || []
  end
end
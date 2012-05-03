class Raid

  attr_reader :id, :when, :leader

  attr_accessor :groups

  def initialize(attrs = {})
    @id = attrs[:id]
    @when = attrs[:when]
    @leader = attrs[:leader]
    @groups = attrs[:groups] || []
  end
end
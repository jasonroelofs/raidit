class Raid

  attr_reader :id, :when, :leader

  def initialize(attrs = {})
    @id = attrs[:id]
    @when = attrs[:when]
    @leader = attrs[:leader]
  end
end
class Guild

  attr_reader :name, :leader

  def initialize(attrs = {})
    @name = attrs[:name]
    @leader = attrs[:leader]
  end
end
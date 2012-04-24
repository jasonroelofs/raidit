class Guild

  attr_reader :id, :name, :leader

  def initialize(attrs = {})
    @id = attrs[:id]
    @name = attrs[:name]
    @leader = attrs[:leader]
  end
end
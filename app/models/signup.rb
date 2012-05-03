class Signup

  attr_reader :raid, :character, :group

  def initialize(attrs = {})
    @raid = attrs[:raid]
    @character = attrs[:character]
    @group = attrs[:group]
  end
end
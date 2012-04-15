class Realm

  attr_reader :region

  attr_reader :name

  attr_reader :timezone

  def initialize(region, name, timezone)
    @region = region
    @name = name
    @timezone = timezone
  end
end
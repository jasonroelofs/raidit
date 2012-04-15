class Guild

  attr_reader :realm

  attr_reader :name

  def initialize(realm, name)
    @realm = realm
    @name = name
  end

end
require 'entity'

class Guild
  include Entity

  attr_accessor :name, :region, :server, :faction

end

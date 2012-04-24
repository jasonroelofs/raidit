require 'models/guild'

##
# This repository stores everything recieved in memory.
# Used in tests to ensure that the repository interface is properly
# called when expected
##
class InMemoryStore

  attr_reader :guilds

  def initialize
    @guilds = [
      Guild.new(name: "Exiled")
    ]
  end

  def save(object)
    if object.is_a?(Guild)
      @guilds << object
    end
  end

end
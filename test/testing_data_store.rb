require 'models/guild'

##
# This repository stores everything recieved in memory.
# Used in tests to ensure that the repository interface is properly
# called when expected
##
class TestingDataStore

  attr_reader :guilds, :raids

  def initialize
    @guilds = [
      Guild.new(id: 1, name: "Exiled")
    ]

    @raids = []
  end

  def save(object)
    case object
    when Guild
      @guilds << object
    when Raid
      @raids << object
    end
  end

end
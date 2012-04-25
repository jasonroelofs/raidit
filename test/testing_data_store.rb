require 'models/guild'
require 'models/raid'
require 'models/user'

##
# This repository stores everything recieved in memory.
# Used in tests to ensure that the repository interface is properly
# called when expected
##
class TestingDataStore

  attr_reader :guilds, :raids, :users

  def initialize
    @guilds = [
      Guild.new(id: 1, name: "Exiled")
    ]

    @raids = []
    @users = []
  end

  def save(object)
    case object
    when Guild
      @guilds << object
    when Raid
      @raids << object
    when User
      @users << object
    end
  end

end
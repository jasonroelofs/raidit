require 'models/guild'
require 'repository'

##
# Register a guild with a given User as the Guild Leader
# and a name
##
class RegisterGuild

  attr_accessor :current_user

  def initialize(current_user)
    @current_user = current_user
  end

  def run(guild_name)
    guild = Guild.new name: guild_name, leader: @current_user
    Repository.for(Guild).save guild
  end

end
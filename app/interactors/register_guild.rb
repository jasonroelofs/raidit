require 'models/guild'
require 'repositories/guild_repository'

##
# Register a guild with a given User as the Guild Leader
# and a name
##
class RegisterGuild

  attr_accessor :name, :leader

  def run
    raise "Guild must have a leader" unless @leader
    raise "Requires a name" unless @name

    guild = Guild.new name: @name, leader: @leader
    GuildRepository.save guild
  end

end
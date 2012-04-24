require 'models/guild'
require 'repositories/guild_repository'

class RegisterGuild

  attr_accessor :name, :leader

  def run
    raise "Guild must have a leader" unless @leader
    raise "Requires a name" unless @name

    guild = Guild.new name: @name, leader: @leader
    GuildRepository.save guild
  end

end
require 'repositories/guild_repository'

class FindGuild

  attr_accessor :by_id, :by_name

  def run
    if @by_id
      GuildRepository.find @by_id
    elsif @by_name
      GuildRepository.find_by_name @by_name
    end
  end
end
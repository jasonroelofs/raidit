require 'repository'
require 'models/guild'

class AddGuild

  def self.from_attributes(attributes)
    Guild.new(attributes).tap do |guild|
      Repository.for(Guild).save(guild)
    end
  end

end

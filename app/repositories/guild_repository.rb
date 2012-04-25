require 'repositories/repository'

class GuildRepository
  class << self
    def find(id)
      data_store.guilds.find {|g| g.id == id }
    end

    def find_by_name(name)
      data_store.guilds.find {|g| g.name == name }
    end

    def save(guild)
      data_store.save guild
    end

    # Not the biggest fan of this, how to give multiple repositories
    # access to the same data store without giving the data store to
    # every single Repository that gets defined.
    def data_store
      Repository.store
    end
  end
end
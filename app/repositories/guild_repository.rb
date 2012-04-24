class GuildRepository
  class << self
    def store=(data_store)
      @store = data_store
    end

    def find(id)
      @store.guilds.find {|g| g.id == id }
    end

    def find_by_name(name)
      @store.guilds.find {|g| g.name == name }
    end

    def save(guild)
      @store.save guild
    end
  end
end
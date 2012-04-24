class RaidRepository
  class << self
    def store=(data_store)
      @store = data_store
    end

    def all
      @store.raids
    end

    def save(raid)
      @store.save raid
    end
  end
end
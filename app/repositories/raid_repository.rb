class RaidRepository
  class << self
    def store=(data_store)
      @store = data_store
    end

    def all
      @store.raids
    end
  end
end
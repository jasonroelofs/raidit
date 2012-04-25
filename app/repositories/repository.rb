class Repository
  class << self
    def store=(data_store)
      @store = data_store
    end

    def store
      @store
    end
  end
end
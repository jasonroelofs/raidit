require 'repositories/repository'

class RaidRepository
  class << self
    def all
      data_store.raids
    end

    def save(raid)
      data_store.save raid
    end

    # See GuildRepository.data_store
    def data_store
      Repository.store
    end
  end
end
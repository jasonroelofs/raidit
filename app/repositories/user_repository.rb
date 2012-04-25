require 'repositories/repository'

class UserRepository
  class << self
    def all
      data_store.users
    end

    # See GuildRepository.data_store
    def data_store
      Repository.store
    end
  end
end
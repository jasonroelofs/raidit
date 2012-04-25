require 'repositories/repository'

class UserRepository
  class << self
    def all
      data_store.users
    end

    def save(user)
      data_store.save user
    end

    # See GuildRepository.data_store
    def data_store
      Repository.store
    end
  end
end
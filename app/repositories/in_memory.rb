module InMemory
  class IndexedRepo
    attr_reader :records

    def initialize
      @id_counter = 0
      @records = []
    end

    def all
      @records
    end

    def find(id)
      @records.find {|r| r.id == id }
    end

    def save(obj)
      obj.id ||= (@id_counter += 1)
      @records << obj
      @records.uniq!
    end
  end

  class GuildRepo < IndexedRepo
    def find_by_name(name)
      records.find {|g| g.name == name }
    end
  end

  class UserRepo < IndexedRepo
    def find_by_login(login)
      records.find {|u| u.login == login }
    end

    def find_by_login_token(type, token)
      records.find {|u| u.login_token(type) == token }
    end
  end

  class CharacterRepo < IndexedRepo
    def find_all_for_user(user)
      records.select {|c| c.user == user }
    end
  end

  class RaidRepo < IndexedRepo
    def find_raids_for_user(user)
      records.select {|r| r.owner == user }
    end

    def find_raids_for_user_and_day(user, day)
      raids = find_raids_for_user(user)
      if day
        raids.select {|raid| raid.when == day }
      else
        raids
      end
    end
  end

  class SignupRepo < IndexedRepo
    def find_all_for_raid(raid)
      records.select {|s| s.raid == raid }
    end
  end

  class PermissionRepo < IndexedRepo
    def find_by_user_and_guild(user, guild)
      records.find {|perm|
        perm.user == user && perm.guild == guild
      }
    end
  end
end

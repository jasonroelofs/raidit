module InMemory
  class GuildRepo

    def initialize
      @guilds = []
    end

    def find(id)
      @guilds.find {|g| g.id == id }
    end

    def find_by_name(name)
      @guilds.find {|g| g.name == name }
    end

    def save(guild)
      @guilds << guild
    end
  end

  class UserRepo
    def initialize
      @users = []
    end

    def save(user)
      @users << user
    end

    def find_by_login(login)
      @users.find {|u| u.login == login }
    end

    def find_by_login_token(type, token)
      @users.find {|u| u.login_token(type) == token }
    end

    def all
      @users
    end
  end

  class CharacterRepo
    def initialize
      @characters = []
      @id_counter = 0
    end

    def save(character)
      character.id ||= (@id_counter += 1)
      @characters << character
    end

    def find(id)
      @characters.find {|c| c.id == id }
    end

    def find_all_for_user(user)
      @characters.select {|c| c.user == user }
    end
  end

  class RaidRepo
    def initialize
      @raids = []
      @id_counter = 0
    end

    def save(raid)
      raid.id ||= (@id_counter += 1)
      @raids << raid
      @raids.uniq!
    end

    def find(id)
      @raids.find {|r| r.id == id }
    end

    def all
      @raids
    end

    def find_raids_for_user(user)
      @raids.select {|r| r.owner == user }
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

  class SignupRepo
    def initialize
      @signups = []
    end

    def save(signup)
      @signups << signup
    end

    def all
      @signups
    end

    def find_all_for_raid(raid)
      @signups.select {|s| s.raid == raid }
    end
  end

  class PermissionRepo
    def initialize
      @perms = []
    end

    def find_by_user_and_guild(user, guild)
      @perms.find {|perm|
        perm.user == user && perm.guild == guild
      }
    end

    def save(perm)
      @perms << perm
    end
  end
end

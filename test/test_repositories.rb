class GuildTestRepo

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

class UserTestRepo
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

class CharacterTestRepo
  def initialize
    @characters = []
  end

  def save(character)
    @characters << character
  end

  def find_all_for_user(user)
    @characters.select {|c| c.user == user }
  end
end

class RaidTestRepo
  def initialize
    @raids = []
  end

  def save(raid)
    @raids << raid
  end

  def all
    @raids
  end

  def find_raids_for_user(user)
    @raids.select {|r| r.owner == user }
  end
end

class SignupTestRepo
  def initialize
    @signups = []
  end

  def save(signup)
    @signups << signup
  end

  def all
    @signups
  end
end

class PermissionTestRepo
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
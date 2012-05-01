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
end
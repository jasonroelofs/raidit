require 'repository'
require 'models/user'

class FindUser

  def self.by_login(login)
    Repository.for(User).find_by_login login
  end

  def self.by_login_token(type, token)
    Repository.for(User).find_by_login_token type, token if token
  end

  def self.by_guild_and_id(guild, user_id)
    user = Repository.for(User).find(user_id)

    if Repository.for(Character).find_main_character(user, guild)
      user
    else
      nil
    end
  end

end

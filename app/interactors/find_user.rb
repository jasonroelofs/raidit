require 'repository'
require 'models/user'

class FindUser

  def by_login(login)
    Repository.for(User).find_by_login login
  end

  def by_login_token(type, token)
    Repository.for(User).find_by_login_token type, token if token
  end

end
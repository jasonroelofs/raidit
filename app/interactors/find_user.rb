require 'repository'
require 'models/user'

class FindUser

  def by_login_token(type, token)
    Repository.for(User).find_by_login_token type, token
  end

end
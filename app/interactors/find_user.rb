require 'repository'
require 'models/user'

class FindUser

  def by_web_session_token(token)
    Repository.for(User).find_by_web_session_token token
  end

end
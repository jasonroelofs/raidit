require 'repository'
require 'models/comment'

class ListComments

  def self.by_signup(signup)
    Repository.for(Comment).find_all_by_signup(signup)
  end

end

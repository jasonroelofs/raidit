require 'entity'

class Comment
  include Entity

  attr_accessor :signup, :user

  attr_accessor :comment
end

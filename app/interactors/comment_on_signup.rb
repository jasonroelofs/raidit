require 'repository'
require 'models/comment'

class CommentOnSignup

  def initialize(current_user, current_signup)
    @current_user = current_user
    @current_signup = current_signup
  end

  def run(comment)
    return nil if !@current_signup || !@current_user || comment.blank?

    comment = Comment.new signup: @current_signup, user: @current_user,
      comment: comment

    Repository.for(Comment).save(comment)
    comment
  end

end

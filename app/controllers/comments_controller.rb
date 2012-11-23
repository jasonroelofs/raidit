class CommentsController < ApplicationController

  requires_user

  # /signups/:signup_id/comments
  #
  # Comment on the signup
  def create
    signup = FindSignup.by_id params[:signup_id].to_i

    if signup
      CommentOnSignup.new(current_user, signup).run(params[:comment][:comment])
      redirect_to raid_path(signup.raid)
    else
      redirect_to root_path
    end
  end

end

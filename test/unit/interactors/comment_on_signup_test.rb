require 'unit/test_helper'
require 'interactors/comment_on_signup'
require 'models/signup'
require 'models/user'

describe CommentOnSignup do

  before do
    @signup = Signup.new id: 4
    @user = User.new id: 5
  end

  it "adds a comment to the signup" do
    comment = CommentOnSignup.new(@user, @signup).run("Commentable!")
    comment.wont_be_nil

    Repository.for(Comment).all.first.must_equal comment
  end

  it "does not add a comment if user is nil" do
    comment = CommentOnSignup.new(nil, @signup).run("Commentable!")
    comment.must_be_nil

    Repository.for(Comment).all.must_equal []
  end

  it "does not add a comment if signup is nil" do
    comment = CommentOnSignup.new(@user, nil).run("Commentable!")
    comment.must_be_nil

    Repository.for(Comment).all.must_equal []
  end

  it "does not add an empty comment" do
    comment = CommentOnSignup.new(@user, @signup).run("")
    comment.must_be_nil

    Repository.for(Comment).all.must_equal []
  end

end

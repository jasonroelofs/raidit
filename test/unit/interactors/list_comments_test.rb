require 'unit/test_helper'
require 'interactors/list_comments'
require 'models/comment'
require 'models/signup'

describe ListComments do

  describe ".by_signup" do
    it "lists all comments owned by the given signup" do
      signup = Signup.new
      comment1 = Comment.new comment: "johnson"
      comment2 = Comment.new comment: "marko", signup: signup

      Repository.for(Comment).save(comment1)
      Repository.for(Comment).save(comment2)

      ListComments.by_signup(signup).must_equal [comment2]
    end
  end
end

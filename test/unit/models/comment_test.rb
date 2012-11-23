require 'unit/test_helper'
require 'models/comment'

describe Comment do

  it "is an entity" do
    Comment.ancestors.must_include Entity
  end

  it "has a comment" do
    Comment.new.comment.must_be_nil
  end

  it "is linked to a signup" do
    Comment.new.signup.must_be_nil
  end

  it "is linked to a user" do
    Comment.new.user.must_be_nil
  end

end

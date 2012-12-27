require 'repositories/test_helper'

describe ActiveRecordRepo::CommentRepo do

  before do
    @repo = ActiveRecordRepo::CommentRepo.new
  end

  it_must_be_a_repo_wrapping ActiveRecordRepo::Models::Comment, ::Comment,
    {:comment => "I'm on TV"}

  describe "#save" do
    it "saves the user and signup recursively" do
      perm = ::Comment.new :user => ::User.new, :signup => ::Signup.new
      @repo.save(perm)

      ActiveRecordRepo::Models::Signup.count.must_equal 1
      ActiveRecordRepo::Models::User.count.must_equal 1

      comment = ActiveRecordRepo::Models::Comment.first
      comment.user.must_equal ActiveRecordRepo::Models::User.first
      comment.signup.must_equal ActiveRecordRepo::Models::Signup.first
    end
  end

  describe "#find" do
    it "also includes user and signup records" do
      in_perm = ::Comment.new :user => ::User.new(:login => "userland"),
        :signup => ::Signup.new(:role => "tank")
      @repo.save(in_perm)

      found = @repo.find(in_perm.id)

      found.user.wont_be_nil
      found.signup.wont_be_nil

      found.user.login.must_equal "userland"
      found.signup.role.must_equal "tank"
    end
  end

  describe "#find_all_by_signup" do
    before do
      @signup = ActiveRecordRepo::Models::Signup.create
      ActiveRecordRepo::Models::Comment.create(:signup => @signup)
      ActiveRecordRepo::Models::Comment.create(:signup => @signup)
      ActiveRecordRepo::Models::Comment.create(:signup => nil)
    end

    it "finds all comments for the given signup" do
      found = @repo.find_all_by_signup(@signup)
      found.length.must_equal 2
    end

    it "returns empty list if no comments found" do
      found = @repo.find_all_by_signup(ActiveRecordRepo::Models::Signup.create)
      found.length.must_equal 0
    end
  end

  describe ActiveRecordRepo::Models::Comment do
    it "belongs to a user" do
      record = ActiveRecordRepo::Models::Comment.new
      record.user.must_be_nil
    end

    it "belongs to a signup" do
      record = ActiveRecordRepo::Models::Comment.new
      record.signup.must_be_nil
    end
  end
end

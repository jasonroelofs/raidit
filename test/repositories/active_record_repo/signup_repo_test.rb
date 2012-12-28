require 'repositories/test_helper'

describe ActiveRecordRepo::SignupRepo do

  before do
    @repo = ActiveRecordRepo::SignupRepo.new
  end

  it_must_be_a_repo_wrapping ActiveRecordRepo::Models::Signup, ::Signup,
    {:acceptance_status => :available, :role => "tank"}

  describe "#save" do
    it "saves the user and raid and character recursively" do
      signup = ::Signup.new :user => ::User.new, :raid => ::Raid.new, :character => ::Character.new
      @repo.save(signup)

      ActiveRecordRepo::Models::Raid.count.must_equal 1
      ActiveRecordRepo::Models::User.count.must_equal 1
      ActiveRecordRepo::Models::Character.count.must_equal 1

      signup = ActiveRecordRepo::Models::Signup.first
      signup.user.must_equal ActiveRecordRepo::Models::User.first
      signup.raid.must_equal ActiveRecordRepo::Models::Raid.first
      signup.character.must_equal ActiveRecordRepo::Models::Character.first
    end
  end

  describe "#find" do
    it "also includes user and raid records" do
      in_perm = ::Signup.new :user => ::User.new(:login => "userland"),
        :raid => ::Raid.new(:where => "ICC")
      @repo.save(in_perm)

      found = @repo.find(in_perm.id)

      found.user.wont_be_nil
      found.raid.wont_be_nil

      found.user.login.must_equal "userland"
      found.raid.where.must_equal "ICC"
    end
  end

  describe "#find_all_for_raid" do
    before do
      @raid = ActiveRecordRepo::Models::Raid.create
      @s1 = ActiveRecordRepo::Models::Signup.create(:raid => @raid)
      @s2 = ActiveRecordRepo::Models::Signup.create(:raid => @raid)
      @s3 = ActiveRecordRepo::Models::Signup.create
    end

    it "returns all signups for the given raid" do
      found = @repo.find_all_for_raid(@raid)
      found.length.must_equal 2
    end
  end

  describe "#find_all_for_user_and_raid" do
    before do
      @raid = ActiveRecordRepo::Models::Raid.create
      @user = ActiveRecordRepo::Models::User.create
      @s1 = ActiveRecordRepo::Models::Signup.create(:raid => @raid)
      @s2 = ActiveRecordRepo::Models::Signup.create(:raid => @raid, :user => @user)
      @s3 = ActiveRecordRepo::Models::Signup.create
    end

    it "returns all signups for the given raid and user" do
      found = @repo.find_all_for_user_and_raid(@user, @raid)
      found.length.must_equal 1
      found.first.id.must_equal @s2.id
    end
  end

  describe "#find_by_raid_and_id" do
    before do
      @raid = ActiveRecordRepo::Models::Raid.create
      @s1 = ActiveRecordRepo::Models::Signup.create(:raid => @raid)
      @s2 = ActiveRecordRepo::Models::Signup.create(:raid => @raid)
      @s3 = ActiveRecordRepo::Models::Signup.create
    end

    it "returns find the signup with the given id and raid" do
      found = @repo.find_by_raid_and_id(@raid, @s1.id)
      found.id.must_equal @s1.id
    end
  end

  describe ActiveRecordRepo::Models::Signup do
    it "belongs to a user" do
      record = ActiveRecordRepo::Models::Signup.new
      record.user.must_be_nil
    end

    it "belongs to a raid" do
      record = ActiveRecordRepo::Models::Signup.new
      record.raid.must_be_nil
    end

    it "belongs to a character" do
      record = ActiveRecordRepo::Models::Signup.new
      record.character.must_be_nil
    end
  end
end

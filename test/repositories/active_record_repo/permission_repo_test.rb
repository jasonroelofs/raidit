require 'repositories/test_helper'

describe ActiveRecordRepo::PermissionRepo do

  before do
    @repo = ActiveRecordRepo::PermissionRepo.new
  end

  it_must_be_a_repo_wrapping ActiveRecordRepo::Models::Permission, ::Permission,
    {:permissions => "permmy"}

  describe "#save" do
    it "saves the user and guild recursively" do
      perm = ::Permission.new :user => ::User.new, :guild => ::Guild.new
      @repo.save(perm)

      ActiveRecordRepo::Models::Guild.count.must_equal 1
      ActiveRecordRepo::Models::User.count.must_equal 1

      permission = ActiveRecordRepo::Models::Permission.first
      permission.user.must_equal ActiveRecordRepo::Models::User.first
      permission.guild.must_equal ActiveRecordRepo::Models::Guild.first
    end
  end

  describe "#find" do
    it "also includes user and guild records" do
      in_perm = ::Permission.new :user => ::User.new(:login => "userland"),
        :guild => ::Guild.new(:name => "Fairy")
      @repo.save(in_perm)

      found = @repo.find(in_perm.id)

      found.user.wont_be_nil
      found.guild.wont_be_nil

      found.user.login.must_equal "userland"
      found.guild.name.must_equal "Fairy"
    end
  end

  describe "permissions" do
    it "converts permissions array to a comma delimited string on save"

    it "converts delimited string to array on find"
  end

  describe ActiveRecordRepo::Models::Permission do
    it "belongs to a user" do
      record = ActiveRecordRepo::Models::Permission.new
      record.user.must_be_nil
    end

    it "belongs to a guild" do
      record = ActiveRecordRepo::Models::Permission.new
      record.guild.must_be_nil
    end
  end

end


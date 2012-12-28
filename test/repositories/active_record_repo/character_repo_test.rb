require 'repositories/test_helper'

describe ActiveRecordRepo::CharacterRepo do

  before do
    @repo = ActiveRecordRepo::CharacterRepo.new
  end

  it_must_be_a_repo_wrapping ActiveRecordRepo::Models::Character, ::Character,
    {:name => "Namezor", :character_class => "Warrior", :is_main => false}

  describe "#save" do
    it "saves the user and guild recursively" do
      character = ::Character.new :user => ::User.new, :guild => ::Guild.new
      @repo.save(character)

      ActiveRecordRepo::Models::Guild.count.must_equal 1
      ActiveRecordRepo::Models::User.count.must_equal 1

      character = ActiveRecordRepo::Models::Character.first
      character.user.must_equal ActiveRecordRepo::Models::User.first
      character.guild.must_equal ActiveRecordRepo::Models::Guild.first
    end
  end

  describe "#find" do
    it "also includes user and guild records" do
      in_perm = ::Character.new :user => ::User.new(:login => "userland"),
        :guild => ::Guild.new(:name => "Fairy")
      @repo.save(in_perm)

      found = @repo.find(in_perm.id)

      found.user.wont_be_nil
      found.guild.wont_be_nil

      found.user.login.must_equal "userland"
      found.guild.name.must_equal "Fairy"
    end
  end

  describe "#find_by_user_and_id" do
    before do
      @user = ActiveRecordRepo::Models::User.create

      @c1 = ActiveRecordRepo::Models::Character.create(:user => @user)
      @c2 = ActiveRecordRepo::Models::Character.create(:user => @user)
      @c3 = ActiveRecordRepo::Models::Character.create
    end

    it "returns the character that matches the user and given id" do
      found = @repo.find_by_user_and_id(@user, @c1.id)
      found.id.must_equal @c1.id
    end
  end

  describe "#find_all_for_user" do
    before do
      @user = ActiveRecordRepo::Models::User.create

      @c1 = ActiveRecordRepo::Models::Character.create(:user => @user)
      @c2 = ActiveRecordRepo::Models::Character.create(:user => @user)
      @c3 = ActiveRecordRepo::Models::Character.create
    end

    it "returns the list character the user owns" do
      found = @repo.find_all_for_user(@user)
      found.length.must_equal 2
    end
  end

  describe "#find_main_character" do
    before do
      @user = ActiveRecordRepo::Models::User.create
      @guild = ActiveRecordRepo::Models::Guild.create

      @c1 = ActiveRecordRepo::Models::Character.create(:user => @user, :guild => @guild)
      @c2 = ActiveRecordRepo::Models::Character.create(:user => @user, :guild => @guild, :is_main => true)
      @c3 = ActiveRecordRepo::Models::Character.create(:user => @user)
    end

    it "returns the main character for the user in the given guild" do
      found = @repo.find_main_character(@user, @guild)
      found.id.must_equal @c2.id
    end
  end

  describe "#find_all_in_guild" do
    before do
      @guild = ActiveRecordRepo::Models::Guild.create

      @c1 = ActiveRecordRepo::Models::Character.create(:guild => @guild)
      @c2 = ActiveRecordRepo::Models::Character.create(:guild => @guild)
      @c3 = ActiveRecordRepo::Models::Character.create
    end

    it "returns the list characters in the given guild" do
      found = @repo.find_all_in_guild(@guild)
      found.length.must_equal 2
    end
  end

  describe "#find_all_for_user_in_guild" do
    before do
      @guild = ActiveRecordRepo::Models::Guild.create
      @user = ActiveRecordRepo::Models::User.create

      @c1 = ActiveRecordRepo::Models::Character.create(:guild => @guild, :user => @user)
      @c2 = ActiveRecordRepo::Models::Character.create(:guild => @guild)
      @c3 = ActiveRecordRepo::Models::Character.create(:user => @user)
    end

    it "returns the list characters in the given guild for the given user" do
      found = @repo.find_all_for_user_in_guild(@user, @guild)
      found.length.must_equal 1
      found.first.id.must_equal @c1.id
    end
  end

  describe ActiveRecordRepo::Models::Character do
    it "belongs to a user" do
      record = ActiveRecordRepo::Models::Character.new
      record.user.must_be_nil
    end

    it "belongs to a guild" do
      record = ActiveRecordRepo::Models::Character.new
      record.guild.must_be_nil
    end
  end
end

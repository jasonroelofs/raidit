require 'test_helper'
require 'interactors/sign_up_to_raid'
require 'models/user'
require 'models/raid'
require 'models/character'

describe SignUpToRaid do
  it "exists" do
    SignUpToRaid.new(nil, nil).wont_be_nil
  end

  it "takes the current user and raid on construction" do
    user = User.new
    raid = Raid.new
    action = SignUpToRaid.new user, raid
    action.current_user.must_equal user
    action.current_raid.must_equal raid
  end

  describe "#run" do
    before do
      @user = User.new
      @character = Character.new
      @raid = Raid.new

      @action = SignUpToRaid.new @user, @raid
    end

    it "doesn't let users sign up characters they don't own"

    it "creates a signup record for the information given" do
      @action.run @character

      repo = Repository.for(Signup)
      signup = repo.all.first

      signup.raid.must_equal @raid
      signup.character.must_equal @character
      signup.user.must_equal @user
    end

    describe "groups" do
      before do
        @raid.groups = [:tank, :healer]
      end

      it "errors if the raid doesn't have the named group" do
        -> {
          @action.run @character, :dps
        }.must_raise RuntimeError
      end

      it "puts character in the specified group" do
        @action.run @character, :tank

        repo = Repository.for(Signup)
        signup = repo.all.first
        signup.group.must_equal :tank
      end

      it "puts the character in the default group if no group specified"
    end
  end
end

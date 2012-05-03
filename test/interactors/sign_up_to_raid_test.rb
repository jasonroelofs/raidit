require 'test_helper'
require 'interactors/sign_up_to_raid'
require 'models/user'
require 'models/raid'
require 'models/character'

describe SignUpToRaid do
  it "exists" do
    SignUpToRaid.new.wont_be_nil
  end

  it "takes the current user" do
    user = User.new
    action = SignUpToRaid.new
    action.user = user
    action.user.must_equal user
  end

  it "takes a raid" do
    raid = Raid.new
    action = SignUpToRaid.new
    action.raid = raid
    action.raid.must_equal raid
  end

  it "takes a character" do
    char = Character.new
    action = SignUpToRaid.new
    action.character = char
    action.character.must_equal char
  end

  it "takes a group" do
    action = SignUpToRaid.new
    action.group = :tank
    action.group.must_equal :tank
  end

  describe "#run" do
    before do
      @user = User.new
      @character = Character.new
      @raid = Raid.new

      @action = SignUpToRaid.new
      @action.user = @user
      @action.character = @character
      @action.raid = @raid
    end

    it "errors if no raid given" do
      @action.raid = nil

      -> {
        @action.run
      }.must_raise RuntimeError
    end

    it "errors if no character given" do
      @action.character = nil

      -> {
        @action.run
      }.must_raise RuntimeError
    end

    it "errors if no user given" do
      @action.user = nil

      -> {
        @action.run
      }.must_raise RuntimeError
    end

    it "doesn't let users sign up characters they don't own"

    it "creates a signup record for the information given" do
      @action.run

      repo = Repository.for(Signup)
      signup = repo.all.first

      signup.raid.must_equal @raid
      signup.character.must_equal @character
    end

    describe "groups" do
      before do
        @raid.groups = [:tank, :healer]
        @action.group = :tank
      end

      it "errors if the raid doesn't have the named group" do
        @action.group = :dps

        -> {
          @action.run
        }.must_raise RuntimeError
      end

      it "puts character in the specified group" do
        @action.run

        repo = Repository.for(Signup)
        signup = repo.all.first
        signup.group.must_equal :tank
      end

      it "puts the character in the default group if no group specified"
    end
  end
end

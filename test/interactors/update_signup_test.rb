require 'test_helper'
require 'interactors/update_signup'
require 'models/user'
require 'models/raid'

describe UpdateSignup do
  it "exists" do
    UpdateSignup.new.wont_be_nil
  end

  it "takes the current user" do
    user = User.new
    action = UpdateSignup.new
    action.current_user = user
    action.current_user.must_equal user
  end

  it "takes a raid" do
    raid = Raid.new
    action = UpdateSignup.new
    action.raid = raid
    action.raid.must_equal raid
  end

  it "takes a signup" do
    s = Signup.new
    action = UpdateSignup.new
    action.signup = s
    action.signup.must_equal s
  end

  it "takes the action to be run" do
    action = UpdateSignup.new
    action.action = :accept
    action.action.must_equal :accept
  end

  describe "#run" do

    before do
      @user = User.new
      @signup = Signup.new
      @raid = Raid.new
      @action = UpdateSignup.new
      @action.current_user = @user
      @action.raid = @raid
      @action.signup = @signup
      @action.action = :accept
    end

    it "errors if no raid" do
      @action.raid = nil

      -> {
        @action.run
      }.must_raise RuntimeError
    end

    it "errors if no current user" do
      @action.current_user = nil

      -> {
        @action.run
      }.must_raise RuntimeError
    end

    it "errors if no signup" do
      @action.signup = nil

      -> {
        @action.run
      }.must_raise RuntimeError
    end

    it "errors if no action was given" do
      @action.action = nil

      -> {
        @action.run
      }.must_raise RuntimeError
    end

    ##
    # Valid state transitions
    ##

    describe "available -> accepted" do
      it "moves the signup to accepted" do
        @action.action = :accept
        @action.run

        @signup.state.must_equal :accepted
      end

      it "saves the changes" do
        @action.action = :accept
        @action.run

        s = Repository.for(Signup).all.first
        s.state.must_equal :accepted
      end

      it "only allows raid leaders to accept"

      it "does not allow signup owner to move"

      it "does not allow non RL and non owners to move"
    end

    describe "accepted -> available" do
      it "updates the signup accordingly" do
        @signup.state = :accepted
        @action.action = :unaccept
        @action.run

        @signup.state.must_equal :available
      end

      it "allows raid leaders to move"

      it "allows the owners of the signup to move"

      it "does not allow non RL and non owners to move"
    end

    describe "available -> cancelled" do
      it "updates the signup accordingly" do
        @signup.state = :available
        @action.action = :cancel
        @action.run

        @signup.state.must_equal :cancelled
      end

      it "allows the owner of the signup to move"

      it "does not allow RL and non owners to move"
    end

    describe "cancelled -> available" do
      it "updates the signup accordingly" do
        @signup.state = :cancelled
        @action.action = :enqueue
        @action.run

        @signup.state.must_equal :available
      end

      it "allows the owner of the signup to move"

      it "does not allow RL and non owners to move"
    end

    describe "accepted -> cancelled" do
      it "updates the signup accordingly" do
        @signup.state = :accepted
        @action.action = :cancel
        @action.run

        @signup.state.must_equal :cancelled
      end

      it "allows the owner of the signup to move"

      it "does not allow RL and non owners to move"
    end

    ##
    # Invalid state transitions
    ##

    #it "doesn't allow transition from cancelled to accepted" do
      #@signup.state = :cancelled
      #@action.action = :accept
      #@action.run

      #@signup.state.must_equal :cancelled
    #end

  end
end

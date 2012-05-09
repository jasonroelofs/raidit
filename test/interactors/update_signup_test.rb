require 'test_helper'
require 'interactors/update_signup'
require 'models/user'
require 'models/raid'
require 'models/permission'

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
      before do
        @perm = Permission.new
        @perm.user = @user
        Repository.for(Permission).save(@perm)

        @action.action = :accept
        @signup.state = :available
      end

      it "fails without the accept_sign_up permission" do
        @action.run

        @signup.state.must_equal :available
      end

      it "moves the signup to accepted" do
        @perm.allow :accept_signup
        @action.run

        @signup.state.must_equal :accepted
      end

      it "saves the changes" do
        @perm.allow :accept_signup
        @action.run

        s = Repository.for(Signup).all.first
        s.state.must_equal :accepted
      end
    end

    describe "accepted -> available" do
      before do
        @perm = Permission.new
        @perm.user = @user
        Repository.for(Permission).save(@perm)

        @action.action = :unaccept
        @signup.state = :accepted
      end

      it "fails without the unaccept_signup permission" do
        @action.run

        @signup.state.must_equal :accepted
      end

      it "updates the signup accordingly" do
        @perm.allow :unaccept_signup
        @action.run

        @signup.state.must_equal :available
      end
    end

    describe "available -> cancelled" do
      before do
        @perm = Permission.new
        @perm.user = @user
        Repository.for(Permission).save(@perm)

        @action.action = :cancel
        @signup.state = :available
      end

      it "fails without cancel_signup permissions" do
        @action.run

        @signup.state.must_equal :available
      end

      it "updates the signup accordingly" do
        @perm.allow :cancel_signup
        @action.run

        @signup.state.must_equal :cancelled
      end
    end

    describe "cancelled -> available" do
      before do
        @perm = Permission.new
        @perm.user = @user
        Repository.for(Permission).save(@perm)

        @action.action = :enqueue
        @signup.state = :cancelled
      end

      it "fails without the enqueue_signup permission" do
        @action.run

        @signup.state.must_equal :cancelled
      end

      it "updates the signup accordingly" do
        @perm.allow :enqueue_signup
        @action.run

        @signup.state.must_equal :available
      end
    end

    describe "accepted -> cancelled" do
      before do
        @perm = Permission.new
        @perm.user = @user
        Repository.for(Permission).save(@perm)

        @action.action = :cancel
        @signup.state = :accepted
      end

      it "fails without the cancel_signup permissions" do
        @action.run

        @signup.state.must_equal :accepted
      end

      it "updates the signup accordingly" do
        @perm.allow :cancel_signup
        @action.run

        @signup.state.must_equal :cancelled
      end
    end

    ##
    # Invalid state transitions
    ##

    it "doesn't allow transition from cancelled to accepted" do
      @signup.state = :cancelled
      @action.action = :accept
      @action.run

      @signup.state.must_equal :cancelled
    end

  end
end

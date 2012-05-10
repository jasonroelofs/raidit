require 'test_helper'
require 'interactors/update_signup'
require 'models/user'
require 'models/raid'
require 'models/permission'

describe UpdateSignup do
  it "exists" do
    UpdateSignup.new(nil, nil).wont_be_nil
  end

  it "requires the current user and signup" do
    user = User.new
    signup = Signup.new
    action = UpdateSignup.new user, signup

    action.current_user.must_equal user
    action.signup.must_equal signup
  end

  describe "#run" do

    before do
      @user = User.new
      @signup = Signup.new
      @action = UpdateSignup.new @user, @signup
    end

    ##
    # Valid state transitions
    ##

    describe "available -> accepted" do
      before do
        @perm = Permission.new
        @perm.user = @user
        Repository.for(Permission).save(@perm)

        @signup.state = :available
      end

      it "fails without the accept_sign_up permission" do
        @action.run :accept

        @signup.state.must_equal :available
      end

      it "moves the signup to accepted" do
        @perm.allow :accept_signup
        @action.run :accept

        @signup.state.must_equal :accepted
      end

      it "saves the changes" do
        @perm.allow :accept_signup
        @action.run :accept

        s = Repository.for(Signup).all.first
        s.state.must_equal :accepted
      end
    end

    describe "accepted -> available" do
      before do
        @perm = Permission.new
        @perm.user = @user
        Repository.for(Permission).save(@perm)

        @signup.state = :accepted
      end

      it "fails without the unaccept_signup permission" do
        @action.run :unaccept

        @signup.state.must_equal :accepted
      end

      it "updates the signup accordingly" do
        @perm.allow :unaccept_signup
        @action.run :unaccept

        @signup.state.must_equal :available
      end
    end

    describe "available -> cancelled" do
      before do
        @perm = Permission.new
        @perm.user = @user
        Repository.for(Permission).save(@perm)

        @signup.state = :available
      end

      it "fails without cancel_signup permissions" do
        @action.run :cancel

        @signup.state.must_equal :available
      end

      it "updates the signup accordingly" do
        @perm.allow :cancel_signup
        @action.run :cancel

        @signup.state.must_equal :cancelled
      end
    end

    describe "cancelled -> available" do
      before do
        @perm = Permission.new
        @perm.user = @user
        Repository.for(Permission).save(@perm)

        @signup.state = :cancelled
      end

      it "fails without the enqueue_signup permission" do
        @action.run :enqueue

        @signup.state.must_equal :cancelled
      end

      it "updates the signup accordingly" do
        @perm.allow :enqueue_signup
        @action.run :enqueue

        @signup.state.must_equal :available
      end
    end

    describe "accepted -> cancelled" do
      before do
        @perm = Permission.new
        @perm.user = @user
        Repository.for(Permission).save(@perm)

        @signup.state = :accepted
      end

      it "fails without the cancel_signup permissions" do
        @action.run :cancel

        @signup.state.must_equal :accepted
      end

      it "updates the signup accordingly" do
        @perm.allow :cancel_signup
        @action.run :cancel

        @signup.state.must_equal :cancelled
      end
    end

    ##
    # Invalid state transitions
    ##

    it "doesn't allow transition from cancelled to accepted" do
      @signup.state = :cancelled
      @action.run :accept

      @signup.state.must_equal :cancelled
    end

  end
end

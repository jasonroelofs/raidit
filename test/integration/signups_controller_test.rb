require 'integration/test_helper'

class SignupsControllerTest < ActionController::TestCase
  tests SignupsController

  describe "#create" do
    it "requires a logged in user" do
      post :create, {}
      must_redirect_to login_path
    end

    describe "when authenticated" do
      before do
        login_as_user
        @raid = Raid.new id: 7
        @character = Character.new id: 4
      end

      it "creates a new signup for the given user's character in the given raid" do
        SignUpToRaid.any_instance.expects(:run).with(7, 4)

        post :create, :raid_id => 7, :character => 4
        must_redirect_to raid_path(:id => 7)
      end

      it "returns to raid page if signup failed"

      it "returns to home page if signup threw an error"
    end
  end

  describe "#update" do
    it "requires a logged in user" do
      put :update, {}
      must_redirect_to login_path
    end

    describe "when authenticated" do
      it "runs the given command to update given signup" do
        login_as_user
        raid = Raid.new id: 7
        signup = Signup.new raid: raid

        FindSignup.expects(:by_id).with(14).returns(signup)
        UpdateSignup.any_instance.expects(:run).with("accept")

        put :update, :id => 14, :command => :accept

        must_redirect_to raid_path(:id => 7)
      end
    end
  end

end

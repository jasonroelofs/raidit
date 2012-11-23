require 'controllers/test_helper'

class SignupsControllerTest < ActionController::TestCase
  tests SignupsController

  describe "#show" do
    it "requires a logged in user" do
      get :show, {}
      must_redirect_to login_path
    end

    it "renders all known comments of the given signup" do
      login_as_user

      signup = Signup.new id: 4
      raid = Raid.new id: 7
      FindRaid.expects(:by_id).returns(raid)
      FindSignup.expects(:by_raid_and_id).with(raid, 4).returns(signup)

      get :show, :raid_id => 7, :id => 4
      must_render_template "show"

      assigns(:signup).must_equal signup
    end
  end

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
        FindRaid.expects(:by_id).with(7).returns(@raid)
        FindCharacter.any_instance.expects(:by_id).with(4).returns(@character)
        SignUpToRaid.any_instance.expects(:run).with(@raid, @character, "dps")

        post :create, :raid_id => 7, :character_id => 4, :role => "dps"

        must_redirect_to raid_path(@raid)
      end
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
        UpdateSignup.any_instance.expects(:run).with(signup, "accept")

        put :update, :id => 14, :command => :accept

        must_redirect_to raid_path(:id => 7)
      end
    end
  end

end

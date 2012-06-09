require 'integration/test_helper'

class RaidsControllerTest < ActionController::TestCase
  tests RaidsController

  describe "#index" do
    it "requires a user" do
      get :index
      must_redirect_to login_path
    end

    it "renders the list of known raids for this user" do
      login_as_user
      FindRaidsForUser.any_instance.expects(:run).returns([])

      get :index

      must_render_template "index"
      assigns(:raids).must_equal []
    end
  end

end

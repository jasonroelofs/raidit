require 'controllers/test_helper'

class GuildsControllerTest < ActionController::TestCase
  tests GuildsController

  describe "access control" do
    it "requires a user for #index" do
      get :index
      must_redirect_to login_path
    end
  end

  describe "#index" do
    it "does a search for guilds based on query, returning json" do
      login_as_user

      g = Guild.new name: "Exiled"
      ListGuilds.expects(:by_partial_name).with("xil").returns([g])

      get :index, :q => "xil", :format => "json"
      assert_response :success
      assigns(:guilds).must_equal [g]

      response.body.must_equal ActiveSupport::JSON.encode([g])
    end
  end
end

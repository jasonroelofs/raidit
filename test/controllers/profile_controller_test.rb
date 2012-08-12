require 'controllers/test_helper'

class ProfileControllerTest < ActionController::TestCase
  tests ProfileController

  describe "access control" do
    it "requires a user for #show" do
      get :show
      must_redirect_to login_path
    end
  end

  it "sets the navigation to :profile" do
    login_as_user
    get :show
    assigns(:current_navigation).must_equal :profile
  end

  describe "#show" do
    it "shows details of the currently logged in user" do
      login_as_user
      get :show
      must_render_template "show"

      assigns(:user).must_equal @user
    end
  end

end

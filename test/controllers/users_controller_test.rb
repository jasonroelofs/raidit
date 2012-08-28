require 'controllers/test_helper'

class UsersControllerTest < ActionController::TestCase
  tests UsersController

  describe "#new" do
    it "shows the sign up form" do
      get :new

      must_render_template "new"
      assigns(:user).wont_be_nil
    end
  end

  describe "#create" do
    it "triggers a user creation and logs the user in" do
      params = {
        :login => "login",
        :password => "passy",
        :password_confirmation => "passy",
        :email => "johnson@gass.com"
      }.with_indifferent_access

      user = User.new
      user.set_login_token(:web, "1234")

      SignUpUser.any_instance.expects(:run).with(params).returns(true)
      LogUserIn.any_instance.expects(:run).with("login", "passy").returns(user)

      post :create, :user => params

      must_redirect_to root_path

      cookies[:web_session_token].must_equal "1234"
    end

    it "re-renders the form if there are errors" do
      SignUpUser.any_instance.expects(:run).returns(false)
      SignUpUser.any_instance.expects(:user).returns(User.new)

      post :create, :user => {}

      must_render_template "new"
      assigns(:user).wont_be_nil
    end
  end
end

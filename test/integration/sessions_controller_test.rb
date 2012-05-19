require 'integration/test_helper'

class SessionsControllerTest < ActionController::TestCase
  tests SessionsController

  describe "#new" do
    it "renders the login page" do
      get :new
      must_respond_with 200
      must_render_template "new"
    end
  end

  describe "#create" do
    before do
      @user = User.new login: "testing", password: "johnson"

      Repository.for(User).save(@user)
    end

    it "finds the user and logs them in" do
      post :create, :login => "testing", :password => "johnson"
      must_redirect_to root_path

      cookies[:web_session_token].wont_be_nil
    end

    it "saves the login token on the user" do
      post :create, :login => "testing", :password => "johnson"

      token = cookies[:web_session_token]
      @user.login_token(:web).must_equal token
    end

    it "re-renders with an error if no user found" do
    end
  end

end

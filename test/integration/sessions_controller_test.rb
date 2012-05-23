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
      post :create, :login => "sandwich", :password => "poodoo"
      must_respond_with 200
      must_render_template "new"

      flash[:login_error].must_equal true
      cookies[:web_session_token].must_be_nil
    end

    it "makes the cookie permanent if remember_me passed in"
  end

  describe "#destroy" do
    it "clears out the login cookies and redirects" do
      @request.cookies[:web_session_token] = "1234567890"

      delete :destroy

      cookies[:web_session_token].must_be_nil
      must_redirect_to root_path
    end

    it "does nothing if no user currently logged in" do
      delete :destroy

      cookies[:web_session_token].must_be_nil
      must_redirect_to root_path
    end

  end

end

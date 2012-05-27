require 'integration/test_helper'

class CharactersControllerTest < ActionController::TestCase
  tests CharactersController

  describe "access control" do
    it "requires a user for #index" do
      get :index
      must_redirect_to login_path
    end
  end

  describe "#index" do
    before do
      @user = User.new login: "test", password: "password"
      Repository.for(User).save @user

      action = LogUserIn.new :web
      @request.cookies[:web_session_token] =
        action.run("test", "password").login_token(:web)
    end

    it "renders the list of characters the current user has" do
      ListCharacters.any_instance.expects(:run).returns([])
      get :index
      assigns(:characters).must_equal []
    end
  end
end


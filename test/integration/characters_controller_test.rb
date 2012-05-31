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
      login_as_user
    end

    it "renders the list of characters the current user has" do
      ListCharacters.any_instance.expects(:run).returns([])
      get :index
      assigns(:characters).must_equal []
    end
  end
end


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
      list = [Character.new]
      ListCharacters.any_instance.expects(:run).returns(list)
      get :index
      assigns(:characters).must_equal list
    end

    it "redirects to #new if there are no characters" do
      ListCharacters.any_instance.expects(:run).returns([])
      get :index

      assert_redirected_to new_character_path
    end
  end

  describe "#new" do
    before do
      login_as_user
    end

    it "renders the new character page" do
      get :new
      must_render_template "new"
    end
  end

  describe "#create" do
    before do
      login_as_user
    end

    it "creates a new character for the current user and redirects to index" do
      AddCharacter.any_instance.expects(:run).with("wow", "US", "Detheroc", "Weemuu")
      post :create, :game => "wow", :region => "US", :server => "Detheroc", :name => "Weemuu"

      assert_redirected_to characters_path
    end
  end
end


require 'controllers/test_helper'

class CharactersControllerTest < ActionController::TestCase
  tests CharactersController

  describe "access control" do
    it "requires a user for #index" do
      get :index
      must_redirect_to login_path
    end
  end

  it "sets the site section to :characters" do
    login_as_user
    get :index
    assigns(:current_navigation).must_equal :characters
  end

  describe "#index" do
    before do
      login_as_user
    end

    it "renders the list of guilded and unguilded characters the current user has" do
      guild1 = Guild.new
      guild2 = Guild.new
      guilded = {guild1 => [Character.new(id: 1)], guild2 => [Character.new(id: 2)]}
      unguilded = [Character.new(id: 3)]

      ListCharacters.any_instance.expects(:guilded).returns(guilded)
      ListCharacters.any_instance.expects(:unguilded).returns(unguilded)

      get :index

      assigns(:guilded_characters).must_equal guilded
      assigns(:unguilded_characters).must_equal unguilded
    end

    it "redirects to #new if there are no characters" do
      ListCharacters.any_instance.expects(:guilded).returns({})
      ListCharacters.any_instance.expects(:unguilded).returns([])

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
      AddCharacter.any_instance.expects(:run).with("Weemuu")
      post :create, :name => "Weemuu"

      must_redirect_to characters_path
    end
  end

  describe "#make_main" do
    it "triggers a main change for the give character" do
      login_as_user
      character = Character.new

      FindCharacter.expects(:by_id).with(10).returns(character)
      SelectMainCharacter.expects(:run).with(character)

      put :make_main, :id => 10

      must_redirect_to characters_path
    end
  end
end


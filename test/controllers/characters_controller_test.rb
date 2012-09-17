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

    it "renders the list of characters owned by the current user" do
      characters = [
        Character.new(id: 1),
        Character.new(id: 2),
        Character.new(id: 3)
      ]

      ListCharacters.expects(:all_for_user).with(@user).returns(characters)

      get :index

      assigns(:characters_by_guild).wont_be_nil
    end

    it "redirects to #new if there are no characters" do
      ListCharacters.expects(:all_for_user).with(@user).returns([])

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

      assigns(:character).wont_be_nil
    end
  end

  describe "#create" do
    before do
      login_as_user
    end

    it "creates a new character for the current user and redirects to index" do
      AddCharacter.any_instance.expects(:run).with(
        'name' => "Weemuu", 'character_class' => "shaman", 'guild_id' => "10"
      ).returns(true)

      post :create, :character => {
        :name => "Weemuu", :character_class => "shaman", :guild_id => 10
      }

      must_redirect_to characters_path
    end

    it "re-renders the form if creation failed" do
      AddCharacter.any_instance.expects(:run).returns(false)
      AddCharacter.any_instance.expects(:character).returns(Character.new)

      post :create, :character => { }

      must_render_template "new"
      assigns(:character).wont_be_nil
    end
  end

  describe "#edit" do
    before do
      login_as_user
    end

    it "renders the edit form for the given character" do
      character = Character.new
      FindCharacter.any_instance.expects(:by_id).with(10).returns(character)

      get :edit, :id => 10

      must_render_template "edit"
      assigns(:character).must_equal character
    end
  end

  describe "#update" do
    before do
      login_as_user
    end

    it "updates the given character with new information" do
      character = Character.new
      FindCharacter.any_instance.expects(:by_id).with(10).returns(character)

      UpdateCharacter.any_instance.expects(:run).with(
        'name' => "New Char Name", 'character_class' => "deathknight").returns(true)

      put :update, :id => 10, :character => {
        :name => "New Char Name",
        :character_class => "deathknight"
      }

      must_redirect_to characters_path
    end

    it "re-renders the form if there were errors" do
      character = Character.new
      FindCharacter.any_instance.expects(:by_id).with(10).returns(character)

      UpdateCharacter.any_instance.expects(:run).returns(false)

      put :update, :id => 10

      must_render_template "edit"
      assigns(:character).must_equal character
    end
  end

  describe "#make_main" do
    it "triggers a main change for the give character" do
      login_as_user
      character = Character.new

      FindCharacter.any_instance.expects(:by_id).with(10).returns(character)
      SelectMainCharacter.expects(:run).with(character)

      put :make_main, :id => 10

      must_redirect_to characters_path
    end
  end
end


require 'controllers/test_helper'

class GuildsControllerTest < ActionController::TestCase
  tests GuildsController

  describe "access control" do
    it "requires a user for #index" do
      get :index
      must_redirect_to login_path
    end
  end

  it "sets the site section to :guilds" do
    login_as_user
    get :index
    assigns(:current_navigation).must_equal :guilds
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

  describe "#show" do
    before do
      login_as_user
      set_main_guild
    end

    it "renders details of the current guild" do
      get :show, :id => 10
      must_render_template "show"

      assigns(:guild).must_equal @guild
    end

    it "finds the list of characters for the guild" do
      chars = [
        Character.new(user: @user),
        Character.new(user: @user)
      ]

      ListCharacters.expects(:all_in_guild).with(@guild).returns(chars)

      get :show, :id => 10

      assigns(:characters).must_equal chars
    end
  end

  describe "#make_current" do
    before do
      login_as_user
    end

    it "changes the current guild to the one given" do
      guild = Guild.new id: 10
      FindGuild.expects(:by_user_and_id).with(@user, 10).returns(guild)
      session[:current_guild_id] = 1

      get :make_current, :id => 10
      must_redirect_to root_path

      session[:current_guild_id].must_equal 10
    end

    it "redirects to the given param if one given" do
      guild = Guild.new id: 10
      FindGuild.expects(:by_user_and_id).with(@user, 10).returns(guild)

      get :make_current, :id => 10, :back_to => raids_path
      must_redirect_to raids_path
    end

    it "doesn't allow changing to a guild the user isn't a member of" do
      FindGuild.expects(:by_user_and_id).with(@user, 10).returns(nil)
      session[:current_guild_id] = 1

      get :make_current, :id => 10
      must_redirect_to root_path

      session[:current_guild_id].must_equal 1
    end

  end
end

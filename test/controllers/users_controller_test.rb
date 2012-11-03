require 'controllers/test_helper'

class UsersControllerTest < ActionController::TestCase
  tests UsersController

  describe "access control" do
    it "requires a user for #show" do
      get :show, :id => 1
      must_redirect_to login_path
    end

    it "requires a user for #edit" do
      get :edit, :id => 1
      must_redirect_to login_path
    end

    it "requires :manage_guild_members for #edit" do
      login_as_user
      get :edit, :id => 1
      must_redirect_to guilds_path
    end
  end

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

  describe "#show" do
    before do
      login_as_user
      set_main_guild

      @main_char = Character.new
      @alt1 = Character.new
      @alt2 = Character.new

      @chars = [ @main_char, @alt1, @alt2 ]

      FindUser.stubs(:by_guild_and_id).returns(@user)
      ListCharacters.stubs(:for_user_in_guild).returns(@chars)
      CheckUserPermissions.any_instance.stubs(:allowed?).returns(false)
    end

    it "finds the user and his characters in the current guild" do
      FindUser.stubs(:by_guild_and_id).with(@guild, 10).returns(@user)
      ListCharacters.stubs(:for_user_in_guild).with(@user, @guild).returns(@chars)

      get :show, :id => 10

      assigns(:user).must_equal @user
      assigns(:characters).must_equal [@main_char, @alt1, @alt2]

      assigns(:current_navigation).must_equal :guilds
    end

    it "lists all current guild permissions if user looking at their self" do
      perm = Permission.new :permissions => [:perm1]
      ListPermissions.expects(:for_user_in_guild).with(@user, @guild).returns(perm)

      get :show, :id => 10

      assigns(:permissions).must_equal perm
    end

    it "redirects to edit if the current user has :manage_guild_members" do
      login_as_guild_leader
      set_main_guild

      other_user = User.new id: 12
      FindUser.stubs(:by_guild_and_id).returns(other_user)

      get :show, :id => 12

      assert_redirected_to edit_user_path(other_user)
    end

    it "does not redirect if the selected user is the current user" do
      char = Character.new
      perm = Permission.new :permissions => [:perm2]

      FindUser.stubs(:by_guild_and_id).returns(@user)

      get :show, :id => 12

      must_render_template "show"
    end

    it "does not show any permissions otherwise" do
      other_user = User.new
      char = Character.new

      FindUser.stubs(:by_guild_and_id).returns(other_user)
      ListCharacters.stubs(:for_user_in_guild).returns([char])
      ListPermissions.expects(:for_user_in_guild).never

      get :show, :id => 12

      assigns(:permissions).must_be_nil
    end
  end

  describe "#edit" do
    before do
      login_as_guild_leader
      set_main_guild
    end

    it "lists all current guild permissions for the current user" do
      other_user = User.new id: 5
      char = Character.new

      perm = Permission.new :permissions => [:perm2]

      FindUser.stubs(:by_guild_and_id).returns(other_user)
      ListCharacters.stubs(:for_user_in_guild).returns([char])
      ListPermissions.expects(:for_user_in_guild).with(other_user, @guild).returns(perm)

      get :edit, :id => 14

      assigns(:all_permissions).must_equal Permission::ALL_PERMISSIONS
      assigns(:user_permissions).must_equal perm
    end

    it "redirects to #show if the requested user is the current user" do
      FindUser.stubs(:by_guild_and_id).returns(@user)
      get :edit, :id => 14

      assert_redirected_to user_path(@user)
    end
  end

end

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

  describe "#show" do
    it "requires a user" do
      get :show, :id => 1
      must_redirect_to login_path
    end

    it "finds the user and his characters in the current guild" do
      login_as_user
      set_main_guild

      chars = [ Character.new, Character.new ]

      FindUser.expects(:by_guild_and_id).with(@guild, 10).returns(@user)
      ListCharacters.expects(:for_user_in_guild).with(@user, @guild).returns(chars)

      get :show, :id => 10

      assigns(:user).must_equal @user
      assigns(:characters).must_equal chars
    end
  end
end

require 'controllers/test_helper'

class ApplicationControllerTest < ActionController::TestCase
  tests ApplicationController

  describe "#current_user" do
    it "returns nil if no current user" do
      @controller.current_user.must_be_nil
    end

    it "finds the user according to the web token cookie" do
      user = User.new
      FindUser.expects(:by_login_token).
        with(:web, "1234567890").returns(user)

      @request.cookies[:web_session_token] = "1234567890"

      @controller.current_user.must_equal user
    end
  end

  describe "#current_guild" do
    it "returns nil if no current user" do
      FindGuild.expects(:by_name).never
      @controller.current_guild.must_be_nil
    end

    it "returns nil if no current guild" do
      login_as_user

      @controller.current_guild.must_be_nil
    end

    it "finds the Exiled guild" do
      login_as_user

      g = Guild.new
      FindGuild.expects(:by_name).with("Exiled").returns(g)

      @controller.current_guild.must_equal g
    end
  end

  describe "#current_user_has_permission?" do
    it "returns false if no current user" do
      @controller.current_user_has_permission?(:permission).must_equal false
    end

    it "runs a permission check on the given permission key" do
      login_as_user
      CheckUserPermissions.any_instance.expects(:allowed?).with(:permission).returns(true)
      @controller.current_user_has_permission?(:permission).must_equal true
    end
  end

end

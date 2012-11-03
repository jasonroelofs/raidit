require 'controllers/test_helper'

class UserPermissionsControllerTest < ActionController::TestCase
  tests UserPermissionsController

  describe "access control" do
    it "requires a user for #update" do
      put :update, :id => 1
      must_redirect_to login_path
    end

    it "requires :manage_guild_members for #update" do
      login_as_user
      put :update, :id => 1
      must_redirect_to guilds_path
    end
  end

  describe "#update" do
    before do
      login_as_guild_leader
      set_main_guild
    end

    it "updates the given user's permissions set under the current guild" do
      user = User.new id: 5
      FindUser.stubs(:by_guild_and_id).returns(user)

      UpdatePermissions.any_instance.expects(:run).with(:schedule_raid)

      put :update, :id => 5, :manage_guild_members => "0", :manage_signups => "0",
        :schedule_raid => "1"

      must_redirect_to edit_user_path(user)
    end
  end
end

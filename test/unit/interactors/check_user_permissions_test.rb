require 'unit/test_helper'
require 'interactors/check_user_permissions'
require 'models/user'
require 'models/guild'

describe CheckUserPermissions do

  it "takes the current user and guild on construction" do
    user = User.new
    guild = Guild.new
    action = CheckUserPermissions.new user, guild

    action.current_user.must_equal user
    action.current_guild.must_equal guild
  end

  describe "#allowed?" do
    before do
      @user = User.new

      @permission = Permission.new
      @permission.user = @user
      @permission.allow :test_permission1
      @permission.allow :testing

      Repository.for(Permission).save(@permission)
    end

    it "checks that the user has the given permission" do
      action = CheckUserPermissions.new @user

      action.allowed?(:test_permission1).must_equal true
      action.allowed?(:test_permission4).must_equal false
    end

    it "scopes permission check to a guild if one given" do
      guild = Guild.new
      g_perm = Permission.new
      g_perm.user = @user
      g_perm.guild = guild
      g_perm.allow :dancing
      Repository.for(Permission).save(g_perm)

      action = CheckUserPermissions.new @user, guild
      action.allowed?(:dancing).must_equal true
      action.allowed?(:testing).must_equal false
    end

    it "returns false if no permissions set found for the user and guild" do
      user2 = User.new

      action = CheckUserPermissions.new user2
      action.allowed?(:testing).must_equal false
    end
  end

end

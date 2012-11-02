require 'unit/test_helper'
require 'interactors/list_permissions'
require 'models/user'
require 'models/guild'

describe ListPermissions do

  before do
    @user = User.new
    @guild = Guild.new

    @permission = Permission.new
    @permission.guild = @guild
    @permission.user = @user
    @permission.allow :test_permission1
    @permission.allow :testing

    Repository.for(Permission).save(@permission)
  end

  it "returns the list of permissions on the given user for the given guild" do
    ListPermissions.for_user_in_guild(@user, @guild).must_equal @permission
  end

  it "returns No Permissions if user isn't in guild" do
    @permission.guild = nil
    Repository.for(Permission).save(@permission)

    assert ListPermissions.for_user_in_guild(@user, @guild).empty?
  end

  it "returns No Permissions if none have been set for the current user" do
    user = User.new
    guild = Guild.new

    assert ListPermissions.for_user_in_guild(user, guild).empty?
  end

end

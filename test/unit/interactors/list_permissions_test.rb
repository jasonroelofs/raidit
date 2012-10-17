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

  it "returns an empty list of user isn't in guild" do
    @permission.guild = nil
    Repository.for(Permission).save(@permission)

    ListPermissions.for_user_in_guild(@user, @guild).must_be_nil
  end

end

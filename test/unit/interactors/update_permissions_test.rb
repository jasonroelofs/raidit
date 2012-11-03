require 'unit/test_helper'
require 'interactors/update_permissions'
require 'models/user'
require 'models/guild'
require 'models/permission'

describe UpdatePermissions do

  describe "#run" do
    before do
      @user = User.new
      @guild = Guild.new
    end

    it "finds existing user permissions for the given guild and updates them" do
      @permission = Permission.new
      @permission.guild = @guild
      @permission.user = @user
      @permission.allow :test_permission1

      Repository.for(Permission).save(@permission)

      UpdatePermissions.new(@user, @guild).run(:perm1, :perm2)

      updated_perm = Repository.for(Permission).find(@permission.id)
      updated_perm.permissions.must_equal [:perm1, :perm2]
    end

    it "adds a new set of permissions to the user and guild if none currently exist" do
      UpdatePermissions.new(@user, @guild).run(:perm1, :perm2)

      new_perm = Repository.for(Permission).all.first
      new_perm.wont_be_nil
      new_perm.permissions.must_equal [:perm1, :perm2]
    end

  end

end

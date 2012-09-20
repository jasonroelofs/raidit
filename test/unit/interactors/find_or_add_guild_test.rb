require 'unit/test_helper'
require 'interactors/find_or_add_guild'
require 'models/guild'
require 'models/user'

describe FindOrAddGuild do

  it "finds a guild by id" do
    guild = Guild.new id: 4, name: "Guildy"
    Repository.for(Guild).save(guild)

    user = User.new

    found = FindOrAddGuild.new(user).from_attributes(guild_id: 4)

    found.must_equal guild
  end

  it "returns nil if no guild by that id exists" do
    user = User.new

    found = FindOrAddGuild.new(user).from_attributes(guild_id: 4)

    found.must_be_nil
  end

  it "creates a new guild by given attributes" do
    guild_attrs = {:guild_id => "new_guild",
                   :guild => {:region => "US", :server => "Johnson", :name => "BlastOff"}}
    user = User.new

    found = FindOrAddGuild.new(user).from_attributes(guild_attrs)
    found.wont_be_nil

    found.name.must_equal "BlastOff"
  end

  it "gives the given user full permissions of the new guild" do
    guild_attrs = {:guild_id => "new_guild",
                   :guild => {:region => "US", :server => "Johnson", :name => "BlastOff"}}
    user = User.new
    Repository.for(User).save(user)

    guild = FindOrAddGuild.new(user).from_attributes(guild_attrs)

    perms = Repository.for(Permission).find_by_user_and_guild(user, guild)
    perms.wont_be_nil
    perms.permissions.must_equal Permission::ALL_PERMISSIONS
  end

end

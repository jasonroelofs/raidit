require 'test_helper'
require 'models/guild'
require 'models/realm'

describe Guild do
  before do
    @realm = Realm.new "US", "Detheroc", "US-Eastern"
    @guild = Guild.new @realm, "Exiled"
  end

  it "exists" do
    @guild.wont_be_nil
  end

  it "is on a realm" do
    @guild.realm.must_equal @realm
  end

  it "has a name" do
    @guild.name.must_equal "Exiled"
  end
end
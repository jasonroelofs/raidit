require 'test_helper'
require 'models/guild'
require 'interactors/find_guild'

describe FindGuild do

  it "exists" do
    FindGuild.new.wont_be_nil
  end

  it "can find a guild by id" do
    Repository.for(Guild).save Guild.new(name: "Exiled", id: 1)

    action = FindGuild.new
    action.by_id = 1

    g = action.run
    g.wont_be_nil
    g.name.must_equal "Exiled"
  end

  it "can find a guild by name" do
    Repository.for(Guild).save Guild.new(name: "Exiled", id: 1)

    action = FindGuild.new
    action.by_name = "Exiled"

    g = action.run
    g.wont_be_nil
    g.id.must_equal 1
  end

  it "returns nil if no guild found for id" do
    action = FindGuild.new
    action.by_id = 134
    action.run.must_be_nil
  end

  it "returns nil if no guild found for name" do
    action = FindGuild.new
    action.by_name = "Johnson"
    action.run.must_be_nil
  end

  it "returns nil if no parameters given" do
    action = FindGuild.new
    action.run.must_be_nil
  end
end
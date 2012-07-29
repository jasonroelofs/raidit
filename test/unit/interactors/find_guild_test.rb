require 'unit/test_helper'
require 'models/guild'
require 'interactors/find_guild'

describe FindGuild do

  it "can find a guild by id" do
    Repository.for(Guild).save Guild.new(name: "Exiled", id: 1)

    guild = FindGuild.by_id 1

    guild.wont_be_nil
    guild.name.must_equal "Exiled"
  end

  it "can find a guild by name" do
    Repository.for(Guild).save Guild.new(name: "Exiled", id: 1)

    guild = FindGuild.by_name "Exiled"

    guild.wont_be_nil
    guild.id.must_equal 1
  end

  it "returns nil if no guild found for id" do
    FindGuild.by_id(134).must_be_nil
  end

  it "returns nil if no guild found for name" do
    FindGuild.by_name("Johnson").must_be_nil
  end

end

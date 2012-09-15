require 'unit/test_helper'
require 'interactors/add_guild'

describe AddGuild do

  it "creates and saves a guild form given attributes" do
    guild = AddGuild.from_attributes :name => "Timmah", :region => "US", :server => "Medivh"

    guild.name.must_equal "Timmah"
    guild.region.must_equal "US"
    guild.server.must_equal "Medivh"

    Repository.for(Guild).all.first.must_equal guild
  end

end

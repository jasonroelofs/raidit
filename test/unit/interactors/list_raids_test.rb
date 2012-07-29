require 'unit/test_helper'
require 'interactors/list_raids'
require 'models/guild'
require 'models/raid'

describe ListRaids do

  describe ".for_guild" do
    it "returns empty list if no raids for the give guild" do
      ListRaids.for_guild(Guild.new).must_equal []
    end

    it "finds all raids owned by the guild" do
      guild = Guild.new

      r1 = Raid.new owner: guild, when: Date.parse("2012/03/01")
      r2 = Raid.new owner: guild, when: Date.parse("2012/04/01")
      r3 = Raid.new
      Repository.for(Raid).save r1
      Repository.for(Raid).save r2
      Repository.for(Raid).save r3

      ListRaids.for_guild(guild).must_equal [r2, r1]
    end
  end

  describe ".for_guild_on_date" do
    it "limits raids to a given date if one given" do
      guild = Guild.new
      r1 = Raid.new owner: guild, when: Date.parse("2012/03/01")
      r2 = Raid.new owner: guild, when: Date.parse("2012/04/01")
      Repository.for(Raid).save r1
      Repository.for(Raid).save r2

      ListRaids.for_guild_on_date(guild, Date.parse("2012/03/01")).must_equal [r1]
    end

    it "returns empty list if no raids for that day" do
      ListRaids.for_guild_on_date(Guild.new, Date.parse("2012/03/01")).must_equal []
    end
  end

end

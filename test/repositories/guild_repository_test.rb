require 'test_helper'
require 'repositories/guild_repository'

describe GuildRepository do
  describe ".find_by_name" do
    it "can find a guild by name" do
      g = GuildRepository.find_by_name("Guild")
      g.wont_be_nil
    end

    it "returns nil if no guild found" do
      g = GuildRepository.find_by_name("Unknown")
      g.must_be_nil
    end
  end

  describe ".save" do
    it "sends the guild down to the store" do
      g = Guild.new name: "Save me"
      GuildRepository.save g

      GuildRepository.find_by_name("Save me").must_equal g
    end
  end
end
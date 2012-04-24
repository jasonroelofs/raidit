require 'test_helper'
require 'repositories/guild_repository'

describe GuildRepository do
  describe ".find_by_name" do
    it "can find a guild by name" do
      g = GuildRepository.find_by_name("Exiled")
      g.wont_be_nil
    end

    it "returns nil if no guild found" do
      g = GuildRepository.find_by_name("Unknown")
      g.must_be_nil
    end
  end

  describe ".find" do
    it "finds a guild by id" do
      g = GuildRepository.find 1
      g.wont_be_nil
      g.name.must_equal "Exiled"
    end

    it "returns nil if no guild found" do
      g = GuildRepository.find 4
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
require 'test_helper'
require 'repositories/raid_repository'
require 'models/raid'

describe RaidRepository do
  describe ".all" do
    it "returns all raids" do
      raids = RaidRepository.all
      raids.length.must_equal 0
    end
  end

  describe ".save" do
    it "sends the raid down to the data store" do
      raid = Raid.new
      RaidRepository.save raid

      RaidRepository.all.must_equal [raid]
    end
  end
end
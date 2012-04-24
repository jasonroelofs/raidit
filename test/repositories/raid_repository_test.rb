require 'test_helper'
require 'repositories/raid_repository'

describe RaidRepository do
  describe ".all" do
    it "returns all raids" do
      raids = RaidRepository.all
      raids.length.must_equal 0
    end
  end
end
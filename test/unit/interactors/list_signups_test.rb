require 'unit/test_helper'
require 'interactors/list_signups'
require 'models/raid'

describe ListSignups do

  describe "#for_raid" do
    before do
      @raid = Raid.new
    end

    it "finds all signups for the given raid, grouped by acceptance state" do
      s1 = Signup.new raid: @raid
      s1.acceptance_status = :accepted

      s2 = Signup.new raid: @raid
      s2.acceptance_status = :available

      Repository.for(Signup).save(s1)
      Repository.for(Signup).save(s2)

      action = ListSignups.new
      action.for_raid(@raid).must_equal({
        :accepted => [s1],
        :available => [s2],
        :cancelled => []
      })
    end

    it "returns empty set if no signups found" do
      action = ListSignups.new
      action.for_raid(@raid).must_equal({
        :accepted => [],
        :available => [],
        :cancelled => []
      })
    end

  end
end

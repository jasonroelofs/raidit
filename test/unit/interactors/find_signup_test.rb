require 'unit/test_helper'
require 'interactors/find_signup'
require 'models/raid'

describe FindSignup do

  describe ".by_raid_and_id" do
    it "returns requested signup in the given raid" do
      r = Raid.new id: 3
      s = Signup.new id: 4, raid: r

      Repository.for(Raid).save(r)
      Repository.for(Signup).save(s)

      FindSignup.by_raid_and_id(r, 4).must_equal s
    end

    it "returns nil if signup doesn't exist in the raid" do
      r = Raid.new id: 3
      Repository.for(Raid).save(r)

      FindSignup.by_raid_and_id(r, 10).must_be_nil
    end

    it "returns nil if the raid doesn't exist" do
      r = Raid.new id: 3

      FindSignup.by_raid_and_id(r, 10).must_be_nil
    end
  end

  describe ".by_id" do
    it "returns the signup with the given id" do
      s = Signup.new id: 4
      Repository.for(Signup).save(s)

      FindSignup.by_id(4).must_equal s
    end
  end

end

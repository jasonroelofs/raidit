require 'unit/test_helper'
require 'models/raid'
require 'models/user'

describe Raid do

  it "is an entity" do
    Raid.ancestors.must_include Entity
  end

  it "takes a hash on construction" do
    time = Time.now
    user = User.new
    r = Raid.new id: 14, when: time, owner: user,
      where: "ICC", start_at: time, invite_at: time

    r.id.must_equal 14
    r.when.must_equal time
    r.owner.must_equal user
    r.where.must_equal "ICC"
    r.start_at.must_equal time
    r.invite_at.must_equal time
  end

  describe "#roles" do
    it "returns the list of roles this Raid contains" do
      r = Raid.new
      r.roles.must_equal Raid::ROLES
    end
  end

  describe "role limits" do

    it "has role limits" do
      r = Raid.new
      r.set_role_limit :tank, 20
      r.role_limit(:tank).must_equal 20
    end

    it "returns nil if no limit set for the requested role" do
      r = Raid.new
      r.role_limit(:johnson).must_be_nil
    end
  end

  describe "#has_role?" do
    it "knows if the raid has a given role" do
      r = Raid.new
      r.has_role?(:tank).must_equal true
      r.has_role?(:bard).must_equal false
    end

    it "works with strings as well" do
      r = Raid.new
      r.has_role?("tank").must_equal true
      r.has_role?("bard").must_equal false
    end
  end

  describe "#size" do
    it "returns the total max number of characters in the raid" do
      r = Raid.new
      r.set_role_limit :tank, 10
      r.set_role_limit :dps,  5
      r.set_role_limit :heal, 4

      r.size.must_equal 19
    end

    it "returns nil if no role limits set" do
      r = Raid.new
      r.size.must_be_nil
    end
  end

  describe "#past?" do
    it "returns true if the raid is now in the past" do
      r1 = Raid.new :when => 2.days.from_now
      r2 = Raid.new :when => 2.days.ago

      assert !r1.past?
      assert r2.past?
    end
  end
end

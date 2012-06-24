require 'unit/test_helper'
require 'models/raid'
require 'models/user'

describe Raid do
  it "exists" do
    Raid.new.wont_be_nil
  end

  it "is an entity" do
    Raid.ancestors.must_include Entity
  end

  it "takes a hash on construction" do
    time = Time.now
    user = User.new
    r = Raid.new id: 14, when: time, leader: user, owner: user,
      where: "ICC", start_at: time, invite_at: time

    r.id.must_equal 14
    r.when.must_equal time
    r.leader.must_equal user
    r.owner.must_equal user
    r.where.must_equal "ICC"
    r.start_at.must_equal time
    r.invite_at.must_equal time
  end

  it "has the three default roles" do
    r = Raid.new
    r.roles.must_equal [:tank, :dps, :healer]
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
end

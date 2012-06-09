require 'unit/test_helper'
require 'models/raid'
require 'models/user'

describe Raid do
  it "exists" do
    Raid.new.wont_be_nil
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

  it "has groups" do
    r = Raid.new
    r.groups = [:dps, :tank]
    r.groups.must_equal [:dps, :tank]
  end
end

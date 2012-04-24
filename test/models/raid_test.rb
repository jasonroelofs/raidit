require 'test_helper'
require 'models/raid'
require 'models/user'

describe Raid do
  it "exists" do
    Raid.new.wont_be_nil
  end

  it "takes a hash on construction" do
    time = Time.now
    user = User.new
    r = Raid.new id: 14, when: time, leader: user

    r.id.must_equal 14
    r.when.must_equal time
    r.leader.must_equal user
  end
end
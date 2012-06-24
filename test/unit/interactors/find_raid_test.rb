require 'unit/test_helper'
require 'interactors/find_raid'

describe FindRaid do

  it "exists" do
    FindRaid.new.wont_be_nil
  end

  it "can find a raid by id" do
    Repository.for(Raid).save Raid.new(where: "ICC", id: 1)

    action = FindRaid.new

    r = action.by_id 1
    r.wont_be_nil
    r.where.must_equal "ICC"
  end
end


require 'unit/test_helper'
require 'interactors/show_raid'

describe ShowRaid do

  it "exists" do
    ShowRaid.new.wont_be_nil
  end

  it "can find a raid by id" do
    Repository.for(Raid).save Raid.new(where: "ICC", id: 1)

    action = ShowRaid.new

    r = action.by_id 1
    r.wont_be_nil
    r.where.must_equal "ICC"
  end
end


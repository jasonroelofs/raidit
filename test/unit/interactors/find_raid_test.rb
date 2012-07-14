require 'unit/test_helper'
require 'interactors/find_raid'

describe FindRaid do

  it "can find a raid by id" do
    Repository.for(Raid).save Raid.new(where: "ICC", id: 1)

    r = FindRaid.by_id 1

    r.wont_be_nil
    r.where.must_equal "ICC"
  end

end

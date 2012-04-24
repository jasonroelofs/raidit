require 'test_helper'
require 'models/guild'
require 'models/user'

describe Guild do
  it "exists" do
    Guild.new.wont_be_nil
  end

  it "takes a hash on construction" do
    u = User.new
    g = Guild.new name: "Exiled", :leader => u
    g.name.must_equal "Exiled"
    g.leader.must_equal u
  end
end
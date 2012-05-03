require 'test_helper'
require 'models/signup'

describe Signup do
  it "exists" do
    Signup.new.wont_be_nil
  end

  it "takes attributes in a hash" do
    s = Signup.new raid: "raid", character: "character"
    s.raid.must_equal "raid"
    s.character.must_equal "character"
  end

  it "can have a group" do
    s = Signup.new group: :dps
    s.group.must_equal :dps
  end
end
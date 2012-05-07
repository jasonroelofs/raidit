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

  it "defaults to the available state" do
    s = Signup.new
    s.state.must_equal :available
    s.available?.must_equal true
  end

  it "can be in the accepted state" do
    s = Signup.new
    s.accepted?.must_equal false

    s.state = :accepted
    s.accepted?.must_equal true
  end

  it "can be in the cancelled state" do
    s = Signup.new
    s.cancelled?.must_equal false

    s.state = :cancelled
    s.cancelled?.must_equal true
  end

end
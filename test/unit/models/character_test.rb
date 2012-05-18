require 'test_helper'
require 'models/character'
require 'models/user'

describe Character do
  it "exists" do
    Character.new.wont_be_nil
  end

  it "takes attributes in a hash" do
    u = User.new
    c = Character.new name: "Weemuu", user: u
    c.name.must_equal "Weemuu"
    c.user.must_equal u
  end
end
require 'test_helper'
require 'models/character'

describe Character do
  it "exists" do
    Character.new.wont_be_nil
  end

  it "takes attributes in a hash" do
    c = Character.new name: "Weemuu"
    c.name.must_equal "Weemuu"
  end
end
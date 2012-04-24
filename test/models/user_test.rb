require 'test_helper'
require 'models/user'

describe User do
  it "exists" do
    User.new.wont_be_nil
  end
end
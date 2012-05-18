require 'test_helper'
require 'models/user'

describe User do
  it "exists" do
    User.new.wont_be_nil
  end

  it "takes attributes in a hash" do
    u = User.new email: "email"
    u.email.must_equal "email"
  end
end
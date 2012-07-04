require 'unit/test_helper'
require 'models/signup'
require 'models/character'

describe Signup do
  it "exists" do
    Signup.new.wont_be_nil
  end

  it "is an entity" do
    Signup.ancestors.must_include Entity
  end

  it "takes attributes in a hash" do
    s = Signup.new user: "user", raid: "raid", character: "character"
    s.user.must_equal "user"
    s.raid.must_equal "raid"
    s.character.must_equal "character"
  end

  it "can have a role" do
    s = Signup.new role: :dps
    s.role.must_equal :dps
  end

  it "defaults to the :available acceptance_status" do
    s = Signup.new
    s.acceptance_status.must_equal :available
    s.available?.must_equal true
  end

  it "can be in the :accepted acceptance_status" do
    s = Signup.new
    s.accepted?.must_equal false

    s.acceptance_status = :accepted
    s.accepted?.must_equal true
  end

  it "can be in the :cancelled acceptance_status" do
    s = Signup.new
    s.cancelled?.must_equal false

    s.acceptance_status = :cancelled
    s.cancelled?.must_equal true
  end

  describe "#character_name" do
    it "returns the name of the linked character" do
      c = Character.new name: "Charzar"
      s = Signup.new character: c

      s.character_name.must_equal "Charzar"
    end

    it "returns empty string if no character or no name" do
      s = Signup.new
      s.character_name.must_equal ""
    end
  end

end

require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "has a name" do
    u = User.new :email => "This is cool"
    u.save

    assert_equal u.email, "This is cool"
  end

  test "has many Characters" do
    u = User.new
    u.characters << Character.new
    u.characters << Character.new
    u.save

    assert_equal u.characters.length, 2
  end

  test "belongs to a guild" do
    u = User.new
    g = Guild.new
    g.users << u
    g.save

    assert_equal u.guild, g
  end
end

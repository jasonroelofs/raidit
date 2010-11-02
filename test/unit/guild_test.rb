require 'test_helper'

class GuildTest < ActiveSupport::TestCase

  test "has a name" do
    g = Guild.new :name => "This is cool"
    g.save

    assert_equal g.name, "This is cool"
  end

  test "has many Users" do
    g = Guild.new
    g.users << User.new
    g.users << User.new
    g.save

    assert_equal g.users.length, 2
  end

end

require 'unit/test_helper'
require 'models/character'
require 'models/guild'
require 'models/user'

describe Character do

  it "is an entity" do
    Character.ancestors.must_include Entity
  end

  it "takes attributes in a hash" do
    u = User.new
    g = Guild.new
    c = Character.new name: "Weemuu", user: u, game: "game", server: "Detheroc",
      region: "US", guild: g, character_class: "Mage"

    c.name.must_equal "Weemuu"
    c.user.must_equal u
    c.game.must_equal "game"
    c.server.must_equal "Detheroc"
    c.region.must_equal "US"
    c.guild.must_equal g
    c.character_class.must_equal "Mage"
  end

  it "knows if it's a main character or not" do
    c = Character.new
    c.main?.must_equal false

    c.is_main = true
    c.main?.must_equal true
  end
end

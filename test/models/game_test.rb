require 'test_helper'
require 'models/game'

describe Game do

  before do
    @game = Game.new("World of Warcraft", "wow")
  end

  it "exists" do
    @game.wont_be_nil
  end

  it "has a full name" do
    @game.name.must_equal "World of Warcraft"
  end

  it "has a short slug" do
    @game.slug.must_equal "wow"
  end

end
require 'unit/test_helper'
require 'models/game'

describe Game do

  describe ".by_short_name" do
    it "returns implementation according to short-name given" do
      found = Game.by_short_name("wow")
      found.must_be_kind_of Game::WoW
    end
  end

  describe "#character_classes" do
    it "returns the list of character classes implemented in the game" do
      found = Game.by_short_name("wow")
      found.character_classes.length.must_equal 11
    end
  end

end

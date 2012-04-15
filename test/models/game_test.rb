require 'test_helper'
require 'models/game'

describe Game do

  it "exists" do
    Game.new.wont_be_nil
  end

end
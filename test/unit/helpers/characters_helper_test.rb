require 'unit/test_helper'
require 'models/character'

require 'helpers/application_helper'
require 'helpers/characters_helper'

describe CharactersHelper do
  include ApplicationHelper
  include CharactersHelper

  describe "#character_icon" do
    it "finds the character class icon for the character" do
      self.expects(:image_tag).with do |image_path, args|
        image_path.must_equal "wow/mage.png"
      end

      character_icon Character.new(game: "wow", character_class: "Mage")
    end

    it "handles character classes with spaces in the name" do
      self.expects(:image_tag).with do |image_path, args|
        image_path.must_equal "wow/deathknight.png"
      end

      character_icon Character.new(game: "wow", character_class: "Death Knight")
    end

    it "renders nothing if no known game" do
      self.expects(:image_tag).never

      character_icon Character.new(character_class: "Death Knight")
    end

    it "renders nothing if no character_class" do
      self.expects(:image_tag).never

      character_icon Character.new(game: "wow")
    end
  end

end

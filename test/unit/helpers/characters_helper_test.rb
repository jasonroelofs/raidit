require 'unit/test_helper'
require 'models/character'
require 'models/game'

require 'helpers/application_helper'
require 'helpers/characters_helper'

describe CharactersHelper do
  include ApplicationHelper
  include CharactersHelper

  describe "#character_classes_for_game" do
    it "returns list of option tags for all classes in the given game" do
      output = character_classes_for_game("wow")

      output.length.must_equal 11
      output[0].must_equal ["Death Knight", "deathknight"]
    end
  end

  describe "#character_icon" do
    it "finds the character class icon for the character" do
      self.expects(:image_tag).with do |image_path, args|
        image_path.must_equal "wow/mage.png"
      end

      character_icon Character.new(character_class: "Mage")
    end

    it "handles character classes with spaces in the name" do
      self.expects(:image_tag).with do |image_path, args|
        image_path.must_equal "wow/deathknight.png"
      end

      character_icon Character.new(character_class: "Death Knight")
    end

    it "renders nothing if no character_class" do
      self.expects(:image_tag).never

      character_icon Character.new
    end
  end

  describe "#sorted_characters_main_first" do
    it "orders the characters by name" do
      c1 = Character.new name: "Weemoo"
      c2 = Character.new name: "Aenoix"
      c3 = Character.new name: "Monster"

      results = sorted_characters_main_first [c1, c2, c3]
      results.must_equal [c2, c3, c1]
    end

    it "forces the main character to the front" do
      c1 = Character.new name: "Weemoo", is_main: true
      c2 = Character.new name: "Aenoix"
      c3 = Character.new name: "Monster"

      results = sorted_characters_main_first [c1, c2, c3]
      results.must_equal [c1, c2, c3]
    end
  end

end

require 'unit/test_helper'
require 'models/characters_by_guild'
require 'models/character'
require 'models/guild'

describe CharactersByGuild do

  it "is enumerable" do
    assert CharactersByGuild.ancestors.include?(Enumerable)
  end

  describe "#empty?" do
    it "is empty if there are no characters" do
      assert CharactersByGuild.new([]).empty?
    end
  end

  describe "#guilds" do
    it "returns list of all guilds, sorted so that Unguilded is last" do
      guild1 = Guild.new id: 1, name: "My Guild"
      guild2 = Guild.new id: 2, name: "Aquafina"
      char1 = Character.new name: "Wonko", guild: guild1
      char2 = Character.new name: "Feeler", guild: nil
      char3 = Character.new name: "Ripper", guild: guild2

      list = CharactersByGuild.new [char1, char2, char3]
      list.guilds.must_equal [guild2, guild1, Guild.new(id: -1, name: "Unguilded")]
    end
  end

  describe "#each" do
    it "iterates over each guild, giving the guild and list of characters" do
      guild1 = Guild.new id: 1, name: "My Guild"
      char1 = Character.new name: "Wonko", guild: guild1
      char2 = Character.new name: "Feeler", guild: nil

      list = CharactersByGuild.new [char1, char2]

      got_guilds = []
      got_characters = []

      list.each do |guild, characters|
        got_guilds << guild
        got_characters << characters
      end

      got_guilds.must_equal [guild1, Guild.new(id: -1, name: "Unguilded")]
      got_characters.must_equal [ [char1], [char2] ]
    end
  end

end

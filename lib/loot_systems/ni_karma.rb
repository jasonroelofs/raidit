module LootSystems
  # LootSystem Implementation for the NiKarma loot system:
  # http://www.wowpedia.org/Ni_Karma
  class NiKarma < LootSystem

    LootEntry = Struct.new(:name, :current, :lifetime)

    def initialize(guild)
      super(guild, "Karma")
    end

    def each_character
      guild.characters.assigned.each do |character|
        if character.loot_lifetime_amount > 0
          yield LootEntry.new(character.name, character.loot_current_amount, character.loot_lifetime_amount)
        end
      end
    end

    def parse_uploaded_file
      # From http://stackoverflow.com/questions/2370153/i-need-a-tool-to-parse-lua-tables-preferrably-in-ruby-or-java
      # Just take the lua table we want, convert it to JSON and parse it that way
      JSON.parse(s.gsub("=", ":").gsub(/[\[\]]/,"").gsub('" :','":').gsub(/,\n(.+)\}/,"\n\\1}"))
    end
  end
end

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
        yield LootEntry.new(character.name, character.loot_current_amount, character.loot_lifetime_amount)
      end
    end
  end
end

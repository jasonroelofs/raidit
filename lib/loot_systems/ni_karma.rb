module LootSystems
  # LootSystem Implementation for the NiKarma loot system:
  # http://www.wowpedia.org/Ni_Karma
  class NiKarma < LootSystem

    LootEntry = Struct.new(:name, :current, :lifetime)

    def initialize(guild)
      super(guild, "Karma")
    end

    def each_character
      10.times do 
        yield LootEntry.new("Some Name", rand, rand)
      end
    end
  end
end

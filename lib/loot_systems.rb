module LootSystems
  # Implement your loot system in # lib/loot_systems.

  # Base class for all loot systems
  class LootSystem
    attr_accessor :name, :guild

    def initialize(guild, name)
      @guild = guild
      @name = name
    end

    def tokenized_name
      self.class.name.split("::").last.underscore
    end
  end
end

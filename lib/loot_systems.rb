module LootSystems
  # Implement your loot system in # lib/loot_systems.

  # Intermediary data structure for taking loot information from
  # an uploaded file and processing it to put into the history of a given
  # character.
  #
  # Subclass this in your loot system definition and define how to get
  # the appropriate requested information
  class LootData
    def get_history_for(character_name)
      raise "Implement me in your LootSystem implementation"
    end

    def current_amount_for(character_name)
      raise "Implement me in your LootSystem implementation"
    end

    def lifetime_amount_for(character_name)
      raise "Implement me in your LootSystem implementation"
    end
  end

  # Base class for all loot systems. Subclass and implement
  # the appropriate methods to implement your loot system handling.
  class LootSystem
    attr_accessor :name, :guild

    def initialize(guild, name)
      @guild = guild
      @name = name
    end

    def tokenized_name
      self.class.name.split("::").last.underscore
    end

    # Given a File handle, parse it's contents.
    # This method needs to return a LootData
    # object with the appropriate fields filled in.
    def process_file(file)
      raise "Implement me in LootSystem subclass."
    end
  end
end

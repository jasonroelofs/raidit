module LootSystems

  class NiKarmaData < LootData
    def initialize(data)
      @data = data
      process
    end

    def get_history_for(character_name)
      get_data(character_name.downcase, "history")
    end

    def current_amount_for(character_name)
      get_data(character_name.downcase, "points")
    end

    def lifetime_amount_for(character_name)
      get_data(character_name.downcase, "lifetime")
    end

    protected

    def get_data(char_name, key)
      if data = @data[char_name]
        data[key]
      else
        nil
      end
    end

    # Take the resulting hash we get and do some conversions
    # to make it easier to work with
    #
    #  * Wrap up all history entries in a :history array
    def process
      @data.each do |char_name, char_data|
        history = []
        char_data.each do |key, value|
          if key =~ /(\d+)/
            id = $1.to_i

            # Build out a Time object from the DT field
            dt = value.delete("DT")
            dt =~ /(\d+)\/(\d+)\/(\d+) (\d+):(\d+):(\d+)/
            value["timestamp"] = Time.mktime("20#{$3}", $1, $2, $4, $5, $6)
            value["amount"] = value.delete("value")

            history[id - 1] = value
          end
        end

        char_data["history"] = history
      end 
    end
  end

  # LootSystem Implementation for the NiKarma loot system:
  # http://www.wowpedia.org/Ni_Karma
  class NiKarma < LootSystem

    LootEntry = Struct.new(:name, :current, :lifetime)

    def initialize(guild)
      super(guild, "Karma")
    end

    def each_character
      guild.characters.each do |character|
        if character.loot_lifetime_amount > 0
          yield LootEntry.new(character.name,
                              character.loot_current_amount,
                              character.loot_lifetime_amount)
        end
      end
    end

    # The file we're working with is a Lua file. We need to take it's contents and convert
    # it to something Ruby can work with, in this case JSON. This conversion is done in
    # lib/lua/ni_karma_parser.lua.
    #
    # Returns a NiKarmaData object
    def process_file(file)
      file_path = file.path
      data = LuaProcessor.run("ni_karma_parser.lua", file_path, "Exiled")
      NiKarmaData.new(data)
    end
  end
end

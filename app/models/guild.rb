class Guild
  include MongoMapper::Document

  # Name of the guild
  key :name, String

  # Location of the guild
  key :realm, String
  key :region, String

  # Secret API key for token requests
  key :api_key, String

  # What kind of loot system is this guild using?
  # Needs to match with the name of implemented LootSystem-s
  # See lib/loot_systems for currently implemented LootSystems
  key :loot_type, String

  # Guilds have Characters
  many :characters, :order => "name ASC"

  # Guilds have many raids
  many :raids

  timestamps!

  attr_accessible :name, :realm, :region

  # Keep track of which guild we're working with
  # for this process
  def self.current=(name)
    Thread.current["guild"] = find_or_create_guild(name)
  end

  def self.current
    Thread.current["guild"]
  end

  # Find, create, or update character data as pulled
  # from the WoW Armory
  def fill_characters_from_armory!
    guild = Armory.guild_info(self.region, self.realm, self.name)
    guild.characters.each do |gc|
      char = self.characters.find_or_create_by_name(gc.name)

      char.name = gc.name
      char.class_name = gc.class_name
      char.race = gc.race
      char.level = gc.level

      char.save
    end

    self.save
  end

  def generate_api_key!
    self.api_key = Digest::SHA1.hexdigest("#{rand}--#{Time.now}--#{self.name}")
    self.save
  end

  # Get a loot system implementation according to what this guild is currently
  # configured to be using.
  def loot_system
    if self.loot_type
      LootSystems.const_get(self.loot_type).new(self)
    end
  end

  protected

  def self.find_or_create_guild(name)
    Guild.find_by_name(name) || 
      Guild.create(:name => name, :region => "US", :realm => "Detheroc")
  end
end

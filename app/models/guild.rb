class Guild
  include MongoMapper::Document

  # Name of the guild
  key :name, String

  # Location of the guild
  key :realm, String

  key :region, String

  # Guilds have Users
  many :characters

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

      char.update_attributes(
        :klass => gc.klass,
        :race => gc.race,
        :level => gc.level
      )
    end

    self.save
  end

  protected

  def self.find_or_create_guild(name)
    Guild.find_by_name(name) || 
      Guild.create(:name => name, :region => "US", :realm => "Detheroc")
  end
end

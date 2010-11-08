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

  # Keep track of which guild we're working with
  # for this process
  def self.current=(name)
    Thread.current["guild"] = find_or_create_guild(name)
  end

  def self.current
    Thread.current["guild"]
  end

  protected

  def find_or_create_guild(name)
    Guild.find_by_name(name) || 
      Guild.create(:name => name, :region => "US", :realm => "Detheroc")
  end
end

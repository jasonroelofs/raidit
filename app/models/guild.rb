class Guild
  include MongoMapper::Document

  # Name of the guild
  key :name, String

  # Location of the guild
  key :realm, String

  # Guilds have Users
  many :characters

  # Guilds have many raids
  many :raids

  timestamps!

  # Keep track of which guild we're working with
  # for this process
  def self.current=(name)
    Thread.current["guild"] = Guild.find_by_name(name)
  end

  def self.current
    Thread.current["guild"]
  end
end

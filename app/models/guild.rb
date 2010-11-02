class Guild
  include MongoMapper::Document

  # Name of the guild
  key :name, String

  # Location of the guild
  key :realm, String

  # Guilds have Users
  many :users
end

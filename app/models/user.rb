# Users are what people log in under. 
# They have multiple characters
class User
  include MongoMapper::Document

  # Login
  key :login, String

  # Permissions setting (admin, raid_leader, user)
  key :role, String

  key :guild_id, ObjectId

  belongs_to :guild

  # Has many characters
  many :characters

  timestamps!
end

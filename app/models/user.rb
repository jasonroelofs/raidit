# Users are what people log in under. 
# They have multiple characters
class User
  include MongoMapper::Document

  # Login email
  key :email, String

  # Permissions setting
  key :role, String

  belongs_to :guild

  # Has many characters
  many :characters
end

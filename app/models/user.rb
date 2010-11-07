# Users are what people log in under. 
# They have multiple characters
class User
  include MongoMapper::Document

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Login via email
  key :email, String

  # Permissions setting (admin, raid_leader, user)
  key :role, String

  key :guild_id, ObjectId

  belongs_to :guild

  # Has many characters
  many :characters

  timestamps!
end

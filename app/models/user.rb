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

  # Find all characters for this user in the 
  # passed in guild
  def characters_in(guild)
    self.characters.where(:guild_id => guild.id).all
  end

  # Keep track of which user we're logged in as
  def self.current=(user)
    Thread.current["user"] = user
  end

  def self.current
    Thread.current["user"]
  end

  # Get the main character of this user.
  # If none are yet flagged, pick the first in the list and flag it
  def main_character
    c = self.characters.where(:is_main => true).first

    if c.nil?
      c = self.characters.first
      c.is_main = true
      c.save
    end

    c
  end

  # Change which character this user's main is. Takes character id
  def change_main_to!(char_id)
    change_to = self.characters.find(char_id)
    change_from = self.main_character

    change_from.is_main = false
    change_to.is_main = true

    change_from.save
    change_to.save
  end
end

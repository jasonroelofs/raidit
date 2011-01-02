# Users are what people log in under. 
# They have multiple characters
class User
  include MongoMapper::Document
  plugin MongoMapper::Devise

  # Login via email
  key :email, String

  # Permissions setting (admin, raid_leader, user)
  key :role, String

  key :guild_id, ObjectId
  belongs_to :guild

  # Has many characters
  many :characters, :order => "is_main DESC, name ASC"

  timestamps!

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable

  # Find all characters for this user in the 
  # passed in guild
  def characters_in(guild)
    self.characters.where(:guild_id => guild.id).all
  end

  # Get the list of character names assigned to this user
  def character_names
    self.characters.map {|c| c.name }
  end

  # Keep track of which user we're logged in as
  def self.current=(user)
    Thread.current["user"] = user
  end

  def self.current
    Thread.current["user"]
  end

  # When building the 'who' for raid events we need
  # a good name. This will be the main character's name, or
  # if there is no character the user's email
  def event_name
    if self.characters.empty?
      self.email
    else
      self.main_character.name
    end
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

  ##
  # User Roles
  ##

  ROLES = %w(
    user
    raid_leader
    admin
  )

  ROLE_STACK = {
    "user" => 0,
    "raid_leader" => 1,
    "admin" => 2
  }

  # Check to see if this user has the requested role
  # for the current guild
  #
  # TODO This system doesn't work for any user who is
  # in multiple guilds. Given this isn't even possible yet
  # we'll "fix" it later
  def has_role?(role)
    (ROLE_STACK[self.role] || 0) >= ROLE_STACK[role.to_s]
  end
end

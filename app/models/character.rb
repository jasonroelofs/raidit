class Character
  include MongoMapper::Document

  key :name,  String
  key :class_name, String
  key :race,  String
  key :user_id, ObjectId
  key :guild_id, ObjectId
  key :is_main, Boolean

  key :level, Integer

  # tank, healer, or dps
  key :main_role, String
  key :off_role, String

  belongs_to :user
  belongs_to :guild

  many :loot_history_entries
  key :loot_current_amount, Float, :default => 0.0
  key :loot_lifetime_amount, Float, :default => 0.0

  timestamps!

  attr_accessible :main_role

  # All characters not currently assigned to a user
  scope :unchosen, :user_id => nil

  # All characters currently assigned to a user
  scope :assigned, :user_id => {"$ne" => nil}

  # Convert the class of this character to something
  # we use in choosing what icon to show
  def class_slug
    self.class_name.downcase.gsub(" ", "")
  end
end

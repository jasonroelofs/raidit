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

  timestamps!

  attr_accessible :main_role

  scope :unchosen, :user_id => nil

  # Convert the class of this character to something
  # we use in choosing what icon to show
  def class_slug
    self.class_name.downcase.gsub(" ", "")
  end
end

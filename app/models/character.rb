class Character
  include MongoMapper::Document

  key :name,  String
  key :class_name, String
  key :race,  String
  key :user_id, ObjectId
  key :guild_id, ObjectId

  key :level, Integer

  belongs_to :user
  belongs_to :guild

  timestamps!

  attr_accessible :name, :class_name, :race, :level

  scope :unchosen, :user_id => nil
end

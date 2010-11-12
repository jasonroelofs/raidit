class Character
  include MongoMapper::Document

  key :name,  String
  key :klass, String
  key :race,  String
  key :user_id, ObjectId
  key :guild_id, ObjectId

  key :level, Integer

  belongs_to :user
  belongs_to :guild

  timestamps!

  attr_accessible :name, :klass, :race, :level

  scope :unchosen, :user_id => nil
end

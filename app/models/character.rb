class Character
  include MongoMapper::Document

  key :name,  String

  key :klass, String

  key :race,  String

  key :user_id, ObjectId

  belongs_to :user

  timestamps!
end

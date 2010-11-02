class Character
  include MongoMapper::Document

  # Name, Class, Race
  key :name,  String
  key :klass, String
  key :race,  String


  belongs_to :user
end

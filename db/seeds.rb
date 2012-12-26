# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Repository.for(User).save(
  jason = User.new(:login => "jason", :password => "password")
)

Repository.for(User).save(
  raider = User.new(:login => "raider", :password => "password")
)

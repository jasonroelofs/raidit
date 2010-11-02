##
# Initializing MongoDB
##

if ENV['MONGOHQ_URL']
  MongoMapper.config = {RAILS_ENV => {'uri' => ENV['MONGOHQ_URL']}}
else
  MongoMapper.config = {RAILS_ENV => {'uri' => 'mongodb://localhost/raidit'}}
end

MongoMapper.connect(RAILS_ENV)

source :rubygems

gem 'bundler', '~> 1.0.3'
gem 'rails',   '3.0.1'

# ORM
gem "mongo", "1.1.5"
gem "bson_ext", "1.1.5"
gem "mongo_mapper", :git => "git://github.com/jnunemaker/mongomapper", :branch => "rails3"

# Rendering
gem "haml"
gem "bistro_car"
gem "cells"

# Libraries
gem "armory", :git => "git://github.com/gaffneyc/armory"
gem "carrierwave", "~> 0.5.0"
gem "fog", "~> 0.3.34"
gem "state_machine", "~> 0.9.4"

# Authentication
gem "devise", "~> 1.1.0"
gem "devise-mongo_mapper", :git => "git://github.com/collectiveidea/devise-mongo_mapper"

# Deployment
gem "heroku"
gem "hoptoad_notifier"

group :development do
  gem "thin"
end 

group :test do
  gem 'database_cleaner', '~> 0.6.0'

  gem 'capybara',         '~> 0.4.0'
  gem 'cucumber',         '~> 0.9.3', :require => false
  gem 'cucumber-rails',   '~> 0.3.2', :require => false
  gem 'launchy',          '~> 0.3.7'

  gem 'timecop'
end

group :test, :development do
  gem 'factory_girl', '~> 1.3.2'

  gem 'ruby-debug',   :platforms => :ruby_18
  gem 'ruby-debug19', :platforms => :ruby_19
end

# vim: set filetype=ruby :

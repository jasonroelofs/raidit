source :rubygems

gem 'bundler', '~> 1.0.3'
gem 'rails',   '3.0.1'

gem "mongo_mapper", :git => "git://github.com/jnunemaker/mongomapper", :branch => "rails3"
gem "bson_ext"

gem "haml"

gem "cells"

# Authentication
gem "devise", "~> 1.1.0"
gem "mm-devise", "~> 1.1.0"

# Deployment
gem "heroku"

group :development do
  gem "thin"
end 

group :test do
  gem 'database_cleaner', '~> 0.6.0'

  gem 'capybara',         '~> 0.4.0'
  gem 'cucumber',         '~> 0.9.3', :require => false
  gem 'cucumber-rails',   '~> 0.3.2', :require => false
  gem 'launchy',          '~> 0.3.7'
end

group :test, :development do
  gem 'factory_girl', '~> 1.3.2'

  gem 'ruby-debug',   :platforms => :ruby_18
  gem 'ruby-debug19', :platforms => :ruby_19
end

# vim: set filetype=ruby :

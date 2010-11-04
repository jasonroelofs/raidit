source :rubygems

gem 'rails', '3.0.1'

gem "mongo_mapper", :git => "git://github.com/jnunemaker/mongomapper", :branch => "rails3"
gem "bson_ext"

gem "haml"

group :development do
  gem "thin"
end 

group :test do
  gem 'rspec-rails',      '~> 2.0.0'
  gem 'database_cleaner', '~> 0.6.0'

  gem 'capybara',         '~> 0.4.0'
  gem 'cucumber',         '~> 0.9.3', :require => false
  gem 'cucumber-rails',   '~> 0.3.2', :require => false
  gem 'launchy',          '~> 0.3.7'
end

group :test, :development do
  gem 'factory_girl', '~> 1.3.2'

#  gem 'ruby-debug',   :platforms => :ruby_18
  gem 'ruby-debug19', :platforms => :ruby_19
end

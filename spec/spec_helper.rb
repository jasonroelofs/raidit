# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # == Mock Framework
  # config.mock_with :mocha
#  config.mock_with :rspec

  config.before(:suite) do
#    DatabaseCleaner.orm = 'mongo_mapper'
#    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
#    DatabaseCleaner.start
  end

  config.after(:each) do
#    DatabaseCleaner.clean
  end
end

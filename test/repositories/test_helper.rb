ENV["RAILS_ENV"] = "test"
ENV["REAL_DB"] = "true"
require File.expand_path('../../../config/environment', __FILE__)
require 'rails/test_help'

require 'rails_test_patches'
require 'database_cleaner'

require 'bcrypt'
Kernel.silence_warnings { BCrypt::Engine::DEFAULT_COST = 1 }

DatabaseCleaner.strategy = :transaction

class MiniTest::Unit::TestCase

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

end

if ENV["NO_COLOR_OUTPUT"].nil?
  require 'minitest/pride'
  MiniTest::Unit.output = PrideLOL.new(MiniTest::Unit.output)
end

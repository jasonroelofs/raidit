ENV["RAILS_ENV"] = "test"
require File.expand_path('../../../config/environment', __FILE__)
require 'rails/test_help'

require 'test_repositories'

class MiniTest::Unit::TestCase

  def setup
    configure_repositories
  end

  def configure_repositories
    Repository.reset!
    Repository.configure(
      "User" => UserTestRepo.new
    )
  end

end

if ENV["NO_COLOR_OUTPUT"].nil?
  require 'minitest/pride'
  MiniTest::Unit.output = PrideLOL.new(MiniTest::Unit.output)
end

require 'rubygems'
gem 'minitest'
require 'minitest/autorun'

require 'mocha_standalone'
require 'debugger'

require 'repository'
require 'test_repositories'

class MiniTest::Unit::TestCase
  include Mocha::API

  def setup
    mocha_teardown
    configure_repositories
  end

  def teardown
    mocha_verify
  end

  def configure_repositories
    Repository.reset!
    Repository.configure(
      "Guild" => GuildTestRepo.new,
      "User" => UserTestRepo.new,
      "Character" => CharacterTestRepo.new,
      "Raid" => RaidTestRepo.new,
      "Signup" => SignupTestRepo.new,
      "Permission" => PermissionTestRepo.new
    )
  end
end

if ENV["NO_COLOR_OUTPUT"].nil?
  require 'minitest/pride'
  MiniTest::Unit.output = PrideLOL.new(MiniTest::Unit.output)
end
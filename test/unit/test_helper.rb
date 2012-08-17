require 'rubygems'
gem 'minitest'
require 'minitest/autorun'

require 'mocha_standalone'

require 'active_support/all'

require 'repository'
require 'repositories/in_memory'

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
      "User"        => InMemory::UserRepo.new,
      "Guild"       => InMemory::GuildRepo.new,
      "Character"   => InMemory::CharacterRepo.new,
      "Raid"        => InMemory::RaidRepo.new,
      "Signup"      => InMemory::SignupRepo.new,
      "Permission"  => InMemory::PermissionRepo.new
    )
  end
end

if ENV["NO_COLOR_OUTPUT"].nil?
  require 'minitest/pride'
  MiniTest::Unit.output = PrideLOL.new(MiniTest::Unit.output)
end

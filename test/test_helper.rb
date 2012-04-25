require 'rubygems'
gem 'minitest'
require 'minitest/autorun'
require 'repositories/repository'
require 'testing_data_store'

require 'mocha_standalone'

class MiniTest::Unit::TestCase
  include Mocha::API

  def setup
    mocha_teardown
    Repository.store = TestingDataStore.new
  end

  def teardown
    mocha_verify
  end
end

if ENV["NO_COLOR_OUTPUT"].nil?
  require 'minitest/pride'
  MiniTest::Unit.output = PrideLOL.new(MiniTest::Unit.output)
end
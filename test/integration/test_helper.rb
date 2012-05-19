ENV["RAILS_ENV"] = "test"
require File.expand_path('../../../config/environment', __FILE__)
require 'rails/test_help'

require 'test_repositories'
require 'rails_test_patches'

module MiniTest::Expectations
  infect_an_assertion :assert_redirected_to, :must_redirect_to
  infect_an_assertion :assert_template, :must_render_template
  infect_an_assertion :assert_response, :must_respond_with
end

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

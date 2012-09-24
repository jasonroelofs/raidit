ENV["RAILS_ENV"] = "test"
require File.expand_path('../../../config/environment', __FILE__)
require 'rails/test_help'

require 'rails_test_patches'
require 'mocha_standalone'

require 'bcrypt'
Kernel.silence_warnings { BCrypt::Engine::DEFAULT_COST = 1 }

module MiniTest::Expectations
  infect_an_assertion :assert_redirected_to, :must_redirect_to
  infect_an_assertion :assert_template, :must_render_template
  infect_an_assertion :assert_response, :must_respond_with
end

class MiniTest::Unit::TestCase
  include Mocha::API

  def setup
    mocha_teardown
  end

  def teardown
    mocha_verify
  end

  def login_as_user
    @user = User.new login: "test", password: "password"
    @user.set_login_token(:web, "1234")
    @request.cookies[:web_session_token] = "1234"

    FindUser.stubs(:by_login_token).with(:web, "1234").returns(@user)
  end

  def login_as_raid_leader
    login_as_user
    Permission::RAID_LEADER.each do |permission|
      CheckUserPermissions.any_instance.stubs(:allowed?).with(permission).returns(true)
    end
  end

  def set_main_guild
    @guild = Guild.new id: 1
    session[:current_guild_id] = 1
    FindGuild.stubs(:by_user_and_id).returns(@guild)
  end
end

if ENV["NO_COLOR_OUTPUT"].nil?
  require 'minitest/pride'
  MiniTest::Unit.output = PrideLOL.new(MiniTest::Unit.output)
end

require 'test_helper'

class ApiControllerTest < ActionController::TestCase

  setup do
    @jason = Factory(:user, :email => "jason@raidit.org")
    @guild = Factory(:guild, :name => "Exiled")
    Guild.current = "Exiled"
    @guild.generate_api_key!
  end

  def build_request(params)
    keys = params.keys.sort
    query = keys.map { |key| [key, params[key]] }.flatten.join("")
    query += @guild.api_key

    hash = Digest::MD5.hexdigest(query)

    params[:signature] = hash
    params
  end

  test "token returns login token with a valid request" do
    get :token, build_request(:email => "jason@raidit.org")

    @jason.reload

    assert_not_nil @jason.authentication_token

    body = ActiveSupport::JSON.decode(response.body)
    assert_equal "success", body["status"]
    assert_equal @jason.authentication_token, body["token"]
  end

  test "error if user doesn't exist" do
    get :token, build_request(:email => "uknown@example.com")

    body = ActiveSupport::JSON.decode(response.body)
    assert_equal "failure", body["status"]
    assert_equal "Unknown user", body["reason"]
  end

  test "error if message doesn't match" do
    params = build_request(:email => "jason@raidit.org")
    @guild.generate_api_key!

    get :token, params

    body = ActiveSupport::JSON.decode(response.body)
    assert_equal "failure", body["status"]
    assert_equal "Hash didn't match", body["reason"]

    @jason.reload
    assert_nil @jason.authentication_token
  end

  test "it creates the user if :create => true is given" do
    get :token, build_request(:email => "uknown@example.com", :create => true)

    body = ActiveSupport::JSON.decode(response.body)
    assert_equal "success", body["status"]

    user = User.find_by_email("uknown@example.com")
    assert_equal user.authentication_token, body["token"]
  end
end

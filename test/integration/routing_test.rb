require 'test_helper'

class RoutingTest < ActionDispatch::IntegrationTest

  test "routes exist" do
    # Root
    assert_routing "/", :controller => "calendar", :action => "show"

    # User login
    assert_routing "/users/sign_in", :controller => "devise/sessions", :action => "new"

    # Raids
    assert_routing "/raids", :controller => "raids", :action => "index"

    # Characters
    assert_routing "/characters", :controller => "characters", :action => "index"
  end
end

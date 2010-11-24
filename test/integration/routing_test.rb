require 'test_helper'

class RoutingTest < ActionDispatch::IntegrationTest

  test "routes exist" do
    # Root
    assert_routing "/", :controller => "calendar", :action => "show"

    # User login
    assert_routing "/users/sign_in", :controller => "devise/sessions", :action => "new"

    # Raids
    assert_routing "/raids", :controller => "raids", :action => "index"
    assert_routing "/raids/37/enqueue", :controller => "raids", :action => "enqueue", :id => 37

    # Characters
    assert_routing "/characters", :controller => "characters", :action => "index"
    assert_routing "/characters/4/associate", :controller => "characters", :action => "associate", :id => 4
    assert_routing "/characters/4/make_main", :controller => "characters", :action => "make_main", :id => 4
  end
end

require 'test_helper'

class RoutingTest < ActionDispatch::IntegrationTest

  test "routes exist" do
    # Root
    assert_routing "/", :controller => "calendar", :action => "show"

    # User login
    assert_routing "/users/sign_in", :controller => "devise/sessions", :action => "new"

    # Raids
    assert_routing "/raids", :controller => "raids", :action => "index"
    #assert_routing "/raids/37/enqueue", :controller => "raids", :action => "enqueue", :id => 37, :method => :put
    assert_routing "/raids/37/update_queue", :controller => "raids", :action => "update_queue", :id => "37"

    # Loot System
    assert_routing "/loot", :controller => "loot", :action => "show"

    # Characters
    assert_routing "/characters", :controller => "characters", :action => "index"
    assert_routing "/characters/search", :controller => "characters", :action => "search"
    assert_routing "/characters/4/associate", :controller => "characters", :action => "associate", :id => "4"
    assert_routing "/characters/4/unassociate", :controller => "characters", :action => "unassociate", :id => "4"
    assert_routing "/characters/4/make_main", :controller => "characters", :action => "make_main", :id => "4"

    # Admin
    assert_routing "/admin", :controller => "admin", :action => "index"
    assert_routing "/admin/raids", :controller => "admin", :action => "raids"
    assert_routing "/admin/logs", :controller => "admin", :action => "logs"
    assert_routing "/admin/api", :controller => "admin", :action => "api"

    assert_routing "/admin/users/14/edit", :controller => "admin", :action => "edit_user", :id => "14"

    # API
    assert_routing "/api/token", :controller => "api", :action => "token"
  end
end

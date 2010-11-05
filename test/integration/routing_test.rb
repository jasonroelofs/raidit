require 'test_helper'

class RoutingTest < ActionDispatch::IntegrationTest

  test "routes exist" do
    assert_routing "/", :controller => "calendar", :action => "show"

    assert_routing(raids_url, {:controller => "raids", :action => "index"})
    assert_routing(raid_url(14), {:controller => "raids", :action => "show", :id => "14"})
  end
end

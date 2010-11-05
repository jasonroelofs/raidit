require 'test_helper'

class RoutingTest < ActionDispatch::IntegrationTest

  test "routes exist" do
    assert_routing "/", :controller => "calendar", :action => "show"
    assert_routing "/raids", :controller => "raids", :action => "index"
  end
end

require 'test_helper'

class RoutingTest < ActionDispatch::IntegrationTest

  test "routes exist" do
    assert_recognizes({:controller => "calendar", :action => "show"}, {:path => "/"})
  end
end

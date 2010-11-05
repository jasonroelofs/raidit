require 'test_helper'

class CalendarControllerTest < ActionController::TestCase

  test "show renders the table" do
    get :show

    assert_template "show"
  end

end

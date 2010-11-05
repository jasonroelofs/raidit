require 'test_helper'

class CalendarCellTest < Cell::TestCase

  test "show shows the base table" do
    invoke :show
    assert_select "table", /Monday/
  end

  test "week renders a weeks worth of information" do
    invoke :week, :which => 0
    assert_select "td .day.today", Date.today.to_s(:day)

    invoke :week, :which => 1
    assert_select "td .day.today", false
  end

end

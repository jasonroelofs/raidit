require 'unit/test_helper'

require 'helpers/navigation_helper'

describe NavigationHelper do
  include NavigationHelper

  def current_navigation
    @current_navigation
  end

  describe "#nav_link_class" do
    it "matchs the link to the current page" do
      @current_navigation = :home

      nav_link_class(:home).must_equal "active"
    end

    it "renders a plain link if the page and link don't match" do
      nav_link_class(:home).must_equal ""
    end
  end
end

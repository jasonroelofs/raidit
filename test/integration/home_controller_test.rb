require 'integration/test_helper'

class HomeControllerTest < ActionController::TestCase
  tests HomeController

  describe "#index" do
    it "renders the home page" do
      get :index
      must_respond_with 200
    end

    it "builds a raid calendar presenter for today and 4 weeks" do
      get :index

      p = assigns(:raid_calendar_presenter)
      p.wont_be_nil
      p.start_date.must_equal Date.today
      p.weeks_to_show.must_equal 4
    end
  end

end

require 'controllers/test_helper'

class HomeControllerTest < ActionController::TestCase
  tests HomeController

  it "sets the site section to :home" do
    get :index
    assigns(:current_navigation).must_equal :home
  end

  describe "#index" do
    it "renders the home page" do
      get :index
      must_respond_with 200
    end

    it "builds a raid calendar presenter for today and 4 weeks" do
      get :index

      p = assigns(:raid_calendar_presenter)
      p.must_be_kind_of RaidCalendarPresenter
    end
  end

end

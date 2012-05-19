require 'integration/test_helper'

class HomeControllerTest < ActionController::TestCase
  tests HomeController

  describe "#index" do
    it "renders the home page" do
      get :index
      must_respond_with 200
    end
  end

end

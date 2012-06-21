require 'integration/test_helper'

class RaidsControllerTest < ActionController::TestCase
  tests RaidsController

  describe "#index" do
    it "requires a user" do
      get :index
      must_redirect_to login_path
    end

    it "renders the list of known raids for this user" do
      login_as_user
      FindRaidsForUser.any_instance.expects(:run).returns([])

      get :index

      must_render_template "index"
      assigns(:raids).must_equal []
    end
  end

  describe "#new" do
    it "requires a user" do
      get :new
      must_redirect_to login_path
    end

    it "renders the new raid form" do
      login_as_user
      get :new
      must_render_template "new"
    end
  end

  describe "#create" do
    it "creates the raid and redirects to index" do
      login_as_user

      ScheduleRaid.any_instance.expects(:run).with("Dragon Soul", Date.parse("2012/01/01"),
        Time.parse("20:00"))

      post :create, :where => "Dragon Soul", :when => "2012/01/01",
        :start => "20:00"

      must_redirect_to raids_path
    end

    it "can take limits for the various roles" do
      login_as_user

      ScheduleRaid.any_instance.expects(:run).with("Dragon Soul", Date.parse("2012/01/01"),
        Time.parse("20:00"), {:tank => 10, :dps => 20, :healer => 100})

      post :create, :where => "Dragon Soul", :when => "2012/01/01",
        :start => "20:00", :tank => 10, :dps => 20, :healer => 100

      must_redirect_to raids_path
    end
  end

end

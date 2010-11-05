require 'spec_helper'

describe CalendarController do

  describe "#show" do
    it "renders the calendar" do
      get :show
      response.should render_template("show")
    end
  end

end

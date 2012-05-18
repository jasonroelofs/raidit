require 'integration/test_helper'

class ApplicationControllerTest < ActionController::TestCase
  tests ApplicationController

  describe "#current_user" do
    it "returns nil if no current user" do
      c = ApplicationController.new
      c.current_user.must_be_nil
    end

    it "returns the current signed in user" do
      user = User.new
      c = ApplicationController.new
      c.current_user = user

      c.current_user.must_equal user
    end
  end
end
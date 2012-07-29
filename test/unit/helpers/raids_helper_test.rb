require 'unit/test_helper'
require 'interactors/update_signup'
require 'models/user'
require 'models/guild'

require 'helpers/raids_helper'

describe RaidsHelper do
  include RaidsHelper

  def current_user
    @user ||= User.new
  end

  def current_guild
    @guild ||= Guild.new
  end

  describe "#render_available_signup_actions" do
    it "renders the list of available actions as links for those actions" do
      signup = Signup.new(id: 4)

      UpdateSignup.any_instance.expects(:available_actions).
        with(signup).returns([:accept, :cancel])

      output = list_available_signup_actions signup
      output.length.must_equal 2

      option = output[0]
      option.name.must_equal "Accept"
      option.action.must_equal :accept

      option = output[1]
      option.name.must_equal "Cancel"
      option.action.must_equal :cancel
    end
  end
end

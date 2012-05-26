require 'unit/test_helper'

require 'helpers/onboarding_helper'
require 'models/user'

describe OnboardingHelper do
  include OnboardingHelper

  def current_user
    @user ||= User.new
  end

  describe "#show_onboarding?" do
    it "returns true if no value set yet for the given onboarding key" do
      show_onboarding?(:characters).must_equal true
    end

    it "returns false if onboarding is set" do
      current_user.onboarded! :characters
      show_onboarding?(:characters).must_equal false
    end
  end
end

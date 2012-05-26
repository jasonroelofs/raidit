require 'interactors/check_onboarding'

module OnboardingHelper

  def show_onboarding?(onboarding_key)
    action = CheckOnboarding.new current_user
    action.run onboarding_key
  end

end
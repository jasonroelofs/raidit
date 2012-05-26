require 'interactors/show_onboarding'

module OnboardingHelper

  def show_onboarding?(onboarding_key)
    action = ShowOnboarding.new current_user
    action.run onboarding_key
  end

end
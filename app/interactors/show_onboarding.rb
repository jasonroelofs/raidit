class ShowOnboarding

  attr_reader :current_user

  def initialize(current_user)
    @current_user = current_user
  end

  ##
  # Given an onboarding flag, see if this user should be shown
  # the requested onboarding key.
  # Returns a boolean
  ##
  def run(onboarding_flag)
    @current_user.requires_onboarding? onboarding_flag
  end
end
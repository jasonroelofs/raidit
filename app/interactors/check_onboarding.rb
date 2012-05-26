class CheckOnboarding

  attr_reader :current_user

  def initialize(current_user)
    @current_user = current_user
  end

  def run(onboarding_flag)
    @current_user.onboarding_value onboarding_flag
  end
end
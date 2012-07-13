module RaidsHelper
  def render_raid_calendar(presenter)
    render partial: "raids/calendar", locals: { presenter: presenter }
  end

  def option_list_of_characters(characters)
    options_from_collection_for_select(characters, :id, :name)
  end

  SignupAction = Struct.new(:name, :action)

  def list_available_signup_actions(signup)
    action = UpdateSignup.new current_user, signup
    action.available_actions.map do |action|
      SignupAction.new action.to_s.camelcase, action
    end
  end
end

module RaidsHelper
  def render_raid_calendar(presenter)
    render partial: "raids/calendar", locals: { presenter: presenter }
  end

  def option_list_of_characters(characters)
    options_for_select(characters.map {|c|
      [c.name, c.id, {"data-character-class" => c.character_class}]
    })
  end

  SignupAction = Struct.new(:name, :action)

  def list_available_signup_actions(signup)
    action = UpdateSignup.new current_user, current_guild
    action.available_actions(signup).map do |action|
      SignupAction.new action.to_s.camelcase, action
    end
  end
end

module RaidsHelper
  def render_raid_calendar(presenter)
    render partial: "raids/calendar", locals: { presenter: presenter }
  end

  def option_list_of_characters(character_guild_map)
    grouped_options_for_select(character_guild_map.map {|guild, characters|
      [guild.name, build_options_from_character_list(characters)]
    })
  end

  def build_options_from_character_list(characters)
    characters.map do |c|
      [c.name, c.id, {"data-character-class" => c.character_class}]
    end
  end

  SignupAction = Struct.new(:name, :action)

  def list_available_signup_actions(signup)
    action = UpdateSignup.new current_user, current_guild
    action.available_actions(signup).map do |action|
      SignupAction.new action.to_s.camelcase, action
    end
  end
end

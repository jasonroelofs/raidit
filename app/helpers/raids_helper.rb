module RaidsHelper

  # Build select options list of characters for the current user
  # and guild, and make sure the main is selected by default
  def character_list(characters, main)
    options_for_select(
      characters.map {|c| [c.name, c.id]},
      main.id
    )
  end

  # Show the list of roles a character can queue for, defaulting
  # to the main role of the main character
  def role_list(main)
    options_for_select(
      [["DPS", "dps"], ["Healer", "healers"], ["Tank", "tanks"]],
      main.main_role
    )
  end

end

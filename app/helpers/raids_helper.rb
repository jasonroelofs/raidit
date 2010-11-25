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
  def role_list(main, list_only = false)
    roles = Wow::AvailableRoles[main.class_name]

    if list_only
      roles
    else
      options_for_select(
        roles.map {|r| [Wow::RoleValueMap[r], r] },
        main.main_role
      )
    end
  end

end

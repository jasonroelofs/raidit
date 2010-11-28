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
  def role_list(main, main_roles_only = true)
    if main_roles_only
      roles = Wow::AvailableRoles[main.class_name]
    else
      roles = Wow::Roles
    end

    options_for_select(
      roles.map {|r| [Wow::RoleValueMap[r], r] },
      main.main_role
    )
  end

  # Figure out which actions to show according to what queue the character
  # is in and what permissions the current user has
  def render_actions(queue, raid, role, char)
    current_user_char = char.user == User.current

    case queue
    when :queued
      if role?(:raid_leader)
        build_action(raid, role, char, :accept)
      elsif current_user_char
        build_action(raid, role, char, :cancel)
      end
    when :accepted
      if role?(:raid_leader)
        build_action(raid, role, char, :queue)
      elsif current_user_char
        build_action(raid, role, char, :cancel)
      end
    when :cancelled
      if current_user_char
        build_action(raid, role, char, :cancel)
      end
    end
  end

  def build_action(raid, role, char, action)
    link_to(image_tag("#{action}.png"), update_queue_raid_path(raid, :role => role, :character => char.id, :do => action))
  end
end

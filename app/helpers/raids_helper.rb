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

    actions = []

    if role?(:raid_leader)
      actions <<
        case queue
        when :queued
          build_action(raid, role, char, :accept)
        when :accepted
          build_action(raid, role, char, :queue)
        when :cancelled
          ""
        end
    end

    if current_user_char
      actions << build_action(raid, role, char, queue == :cancelled ? :queue : :cancel)
    end

    if role?(:raid_leader) || current_user_char
      actions << link_to(image_tag("note.png"), add_note_raid_path(raid, :character_id => char.id),
                         :class => "note button small")
    end

    content_tag(:div, :class => "main") { actions.first } + content_tag(:div, :class => "all") { actions.reverse.join }
  end

  def build_action(raid, role, char, action)
    link_to(image_tag("#{action}.png"), 
            update_queue_raid_path(raid, :role => role, :character => char.id, :do => action),
            :title => action.capitalize,
            :class => "#{action} button small"
           )
  end
end

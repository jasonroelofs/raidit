require 'interactors/find_guild'
require 'interactors/add_guild'
require 'models/permission'

class FindOrAddGuild

  def initialize(current_user)
    @current_user = current_user
  end

  def from_attributes(attributes)
    guild_id, guild_attrs = attributes.values_at :guild_id, :guild

    if guild_attrs && guild_id == "new_guild"
      add_guild_and_give_user_full_permissions guild_attrs
    elsif guild_id.present?
      FindGuild.by_id guild_id.to_i
    else
      nil
    end
  end

  protected

  def add_guild_and_give_user_full_permissions(attributes)
    AddGuild.from_attributes(attributes).tap do |guild|
      permission = Permission.new guild: guild,
        user: @current_user, permissions: Permission::ALL_PERMISSIONS

      Repository.for(Permission).save(permission)
    end
  end

end

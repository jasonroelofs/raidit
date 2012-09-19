module GuildsHelper

  def available_guilds
    ListGuilds.by_user(current_user).reject do |guild|
      guild == current_guild
    end
  end

  # NOTE Not currently used, but do want to have your current guilds
  # pre-populated in the Guild Select box, just need to figure out how
  # to make select2 do this.
  def guild_selection_list
    guilds = ListGuilds.by_user current_user
    [["Unguilded"]] + guilds.map {|g| [g.name, g.id] }
  end

  protected

  def guild_data(guild)
    {
      "data-realm" => guild.realm,
      "data-region" => guild.region,
      "data-faction" => guild.faction
    }
  end

end

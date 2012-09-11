module GuildsHelper

  def guild_selection_list
    guilds = ListGuilds.by_user current_user
    [
      ["Your Guilds",
        guilds.map {|g| [g.name, g.id] }
      ]
    ]
  end

end

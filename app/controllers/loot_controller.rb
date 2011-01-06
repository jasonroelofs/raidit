class LootController < ApplicationController

  # Public display of the current status of this guild's
  # loot system.
  def show
    @loot = current_guild.loot_system
  end

  # Show the loot history of the given character
  def history
    @loot = current_guild.loot_system
    @character = current_guild.characters.where(:name => params[:name]).first
    @history = @character.loot_history_entries
  end
end

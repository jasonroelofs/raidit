class LootController < ApplicationController

  # Public display of the current status of this guild's
  # loot system.
  def show
    @loot = current_guild.loot_system
  end
end

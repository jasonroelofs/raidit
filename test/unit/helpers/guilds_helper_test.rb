require 'unit/test_helper'
require 'models/user'
require 'models/guild'

require 'interactors/list_guilds'

require 'helpers/guilds_helper'

describe GuildsHelper do
  include GuildsHelper

  def current_user
    @user ||= User.new
  end

  def current_guild
    @current_guild
  end

  describe "#available_guilds" do
    it "returns all guilds available to the current user that aren't the current guild" do
      guild1 = Guild.new
      guild2 = Guild.new
      guild3 = Guild.new

      @current_guild = guild2
      ListGuilds.expects(:by_user).with(current_user).returns([guild1, guild2, guild3])

      available_guilds.must_equal [guild1, guild3]
    end
  end

  describe "#guild_selection_list" do

    it "finds all the current user's guilds and sets up the selector" do
      guild = Guild.new name: "Guildolocks", id: 1
      ListGuilds.expects(:by_user).with(current_user).returns([guild])

      guild_selection_list.must_equal [["Unguilded"], ["Guildolocks", 1]]
    end

  end

end

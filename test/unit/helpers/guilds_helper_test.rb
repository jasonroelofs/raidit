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

  describe "#guild_selection_list" do

    it "finds all the current user's guilds and sets up the selector" do
      guild = Guild.new name: "Guildolocks", id: 1
      ListGuilds.expects(:by_user).with(current_user).returns([guild])

      guild_selection_list.must_equal [["Unguilded"], ["Guildolocks", 1]]
    end

  end

end

require 'unit/test_helper'
require 'interactors/list_guilds'
require 'models/user'
require 'models/guild'
require 'models/character'

describe ListGuilds do

  describe ".by_user" do
    before do
      @user = User.new

      @guild1 = Guild.new
      @guild2 = Guild.new
      @guild3 = Guild.new

      @char1 = Character.new user: @user, guild: @guild1
      @char2 = Character.new user: @user, guild: @guild2

      Repository.for(Character).save(@char1)
      Repository.for(Character).save(@char2)
    end

    it "lists all guilds the given user is a member of" do
      ListGuilds.by_user(@user).must_equal [@guild1, @guild2]
    end
  end
end

require 'unit/test_helper'
require 'interactors/register_guild'
require 'models/user'

describe RegisterGuild do
  it "exists" do
    RegisterGuild.new(nil).wont_be_nil
  end

  it "takes the current user in construction" do
    user = User.new
    g = RegisterGuild.new user
    g.current_user.must_equal user
  end

  describe "#run" do
    before do
      @user = User.new
      @action = RegisterGuild.new @user
    end

    it "creates and saves the guild" do
      @action.run "Johnson"

      guild = Repository.for(Guild).find_by_name "Johnson"
      guild.wont_be_nil
      guild.leader.must_equal @user
    end
  end

end

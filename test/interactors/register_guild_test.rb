require 'test_helper'
require 'interactors/register_guild'
require 'models/user'

describe RegisterGuild do
  it "exists" do
    RegisterGuild.new.wont_be_nil
  end

  it "takes a name" do
    g = RegisterGuild.new
    g.name = "Guild Name"
    g.name.must_equal "Guild Name"
  end

  it "takes a leader" do
    g = RegisterGuild.new
    leader = User.new

    g.leader = leader
    g.leader.must_equal leader
  end

  describe "#run" do
    before do
      @action = RegisterGuild.new
      @leader = User.new
      @action.leader = @leader
      @action.name = "Johnson"
    end

    it "requires a name" do
      @action.name = nil
      -> {
        @action.run
      }.must_raise RuntimeError
    end

    it "requires a leader" do
      @action.leader = nil
      -> {
        @action.run
      }.must_raise RuntimeError
    end

    it "creates and saves the guild" do
      @action.run
      guild = GuildRepository.find_by_name "Johnson"
      guild.wont_be_nil
      guild.leader.must_equal @leader
    end
  end

end
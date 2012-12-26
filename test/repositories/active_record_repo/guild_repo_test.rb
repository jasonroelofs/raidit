require 'repositories/test_helper'

describe ActiveRecordRepo::GuildRepo do

  before do
    @repo = ActiveRecordRepo::GuildRepo.new
  end

  describe "#find" do
    it "finds the guild by id and convers to domain model" do
      ar_guild = ActiveRecordRepo::Models::Guild.create(
        :name => "Johnson", :region => "US", :server => "hashor")

      guild = @repo.find(ar_guild.id)
      guild.wont_be_nil

      guild.must_be_kind_of ::Guild
      guild.id.must_equal ar_guild.id
      guild.name.must_equal "Johnson"
      guild.region.must_equal "US"
      guild.server.must_equal "hashor"
    end
  end

  describe "#save" do
    it "takes the Guild, stores it in the db" do
      guild = ::Guild.new(:name => "myxo", :region => "US", :server => "Detheroc")
      @repo.save(guild)

      ar_guild = ActiveRecordRepo::Models::Guild.all.first
      ar_guild.wont_be_nil
      ar_guild.name.must_equal "myxo"
      ar_guild.region.must_equal "US"
      ar_guild.server.must_equal "Detheroc"

      guild.id.must_equal ar_guild.id
    end

    it "updates an existing Guild in the db with the same id" do
      guild = ::Guild.new(:name => "myxo", :region => "US", :server => "Detheroc")
      @repo.save(guild)

      guild.region = "EU"
      guild.name = "partyboy"

      @repo.save(guild)

      ActiveRecordRepo::Models::Guild.count.must_equal 1

      ar_guild = ActiveRecordRepo::Models::Guild.find(guild.id)
      ar_guild.region.must_equal "EU"
      ar_guild.name.must_equal "partyboy"
      ar_guild.server.must_equal "Detheroc"
    end
  end

  describe "#find_by_name" do
    before do
      ActiveRecordRepo::Models::Guild.create(:name => "testing1")
      ActiveRecordRepo::Models::Guild.create(:name => "picakboo")
      ActiveRecordRepo::Models::Guild.create(:name => "proper")
    end

    it "finds the Guild by given name" do
      found = @repo.find_by_name("testing1")
      found.wont_be_nil
      found.name.must_equal "testing1"
    end

    it "returns nil if no guild with that name found" do
      @repo.find_by_name("thefu?").must_be_nil
    end
  end

  describe "#search_by_name" do
    before do
      ActiveRecordRepo::Models::Guild.create(:name => "testing1")
      ActiveRecordRepo::Models::Guild.create(:name => "picker")
      ActiveRecordRepo::Models::Guild.create(:name => "picking")
    end

    it "finds all Guilds who's name matches the query" do
      found = @repo.search_by_name("pick")
      found.length.must_equal 2

      found[0].name.must_equal "picker"
      found[1].name.must_equal "picking"
    end

    it "returns empty list if no guild with that name found" do
      @repo.search_by_name("thefu?").must_be_empty
    end
  end

end

require 'repositories/test_helper'

describe ActiveRecordRepo::GuildRepo do

  before do
    @repo = ActiveRecordRepo::GuildRepo.new
  end

  it_must_be_a_repo_wrapping ActiveRecordRepo::Models::Guild, ::Guild,
    {:name => "Guildy", :region => "US", :server => "Medivh"}

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

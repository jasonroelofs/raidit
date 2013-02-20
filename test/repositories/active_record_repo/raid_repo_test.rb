require 'repositories/test_helper'

describe ActiveRecordRepo::RaidRepo do

  before do
    @repo = ActiveRecordRepo::RaidRepo.new
  end

  it_must_be_a_repo_wrapping ActiveRecordRepo::Models::Raid, ::Raid,
    {:where => "ICC", :when => Time.now.utc, :start_at => Time.now.utc, :invite_at => 1.day.from_now,
      :role_limits => {:tank => 1}}

  describe "#save" do
    it "saves the guild recursively" do
      perm = ::Raid.new :owner => ::Guild.new
      @repo.save(perm)

      ActiveRecordRepo::Models::Guild.count.must_equal 1

      raid = ActiveRecordRepo::Models::Raid.first
      raid.owner.must_equal ActiveRecordRepo::Models::Guild.first
    end
  end

  describe "#find" do
    it "also includes the guild record" do
      in_perm = ::Raid.new :owner => ::Guild.new(:name => "Fairy")
      @repo.save(in_perm)

      found = @repo.find(in_perm.id)

      found.owner.wont_be_nil
      found.owner.name.must_equal "Fairy"
    end
  end

  describe "#find_raids_for_guild" do
    before do
      @guild = ActiveRecordRepo::Models::Guild.create(:name => "johnson")
      ActiveRecordRepo::Models::Raid.create(:owner => @guild)
      ActiveRecordRepo::Models::Raid.create(:owner => @guild)
      ActiveRecordRepo::Models::Raid.create(:owner => nil)
    end

    it "finds all raids for the given guild" do
      found = @repo.find_raids_for_guild(@guild)
      found.length.must_equal 2
    end

    it "returns empty list if no raids found" do
      found = @repo.find_raids_for_guild(ActiveRecordRepo::Models::Guild.create)
      found.length.must_equal 0
    end
  end

  describe "#find_raids_for_guild_and_day" do
    before do
      @guild = ActiveRecordRepo::Models::Guild.create(:name => "johnson")
      @r1 = ActiveRecordRepo::Models::Raid.create(:owner => @guild, :when => Date.today)
      @r2 = ActiveRecordRepo::Models::Raid.create(:owner => @guild, :when => Date.tomorrow)
      @r3 = ActiveRecordRepo::Models::Raid.create(:owner => nil)
    end

    it "finds all raids for the given guild and day" do
      found = @repo.find_raids_for_guild_and_day(@guild, Date.today)
      found.first.id.must_equal @r1.id
    end
  end

  describe ActiveRecordRepo::Models::Raid do
    it "belongs to a guild through owner" do
      record = ActiveRecordRepo::Models::Raid.new
      record.owner.must_be_nil
    end

    it "converts raid roles to Fixnums when loading from DB" do
      ActiveRecordRepo::Models::Raid.create :role_limits => {:tank => 4, :dps => 3}

      raid = ActiveRecordRepo::Models::Raid.all.first
      raid.role_limits[:tank].must_equal 4
      raid.role_limits[:dps].must_equal 3
    end
  end
end

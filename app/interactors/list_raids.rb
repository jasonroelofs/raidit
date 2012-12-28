##
# Returns the full list of raids that given user is allowed to see.
##
class ListRaids

  def self.for_guild(guild)
    sort_newest_first Repository.for(Raid).find_raids_for_guild(guild)
  end

  def self.for_guild_on_date(guild, date)
    sort_newest_first Repository.for(Raid).find_raids_for_guild_and_day(guild, date)
  end

  protected

  def self.sort_newest_first(list)
    list.sort {|r1, r2| r2.when <=> r1.when }
  end

end

##
# Returns the full list of raids that given user is allowed to see.
##
class ListRaids

  def self.for_guild(guild)
    for_guild_on_date(guild, nil)
  end

  def self.for_guild_on_date(guild, date)
    Repository.for(Raid).find_raids_for_guild_and_day(guild, date).
      sort {|r1, r2| r2.when <=> r1.when }
  end

end

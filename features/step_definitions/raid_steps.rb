def find_user_by_login(login)
  Repository.for(User).find_by_login(login)
end

Given /^"(.*?)" has scheduled the following raids$/ do |guild_name, table|
  current_guild = FindGuild.by_name(guild_name)
  repo = Repository.for(Raid)

  table.hashes.each do |row|
    raid_when = row[:when] == "today" ? Date.today : Date.parse(row[:when])

    r = Raid.new(
      :owner => current_guild,
      :where => row[:where],
      :when => raid_when,
      :start_at => Time.parse(row[:start]),
      :invite_at => Time.parse(row[:start]) - row[:invite_offset].to_i.minutes
    )

    [:tank, :heal, :dps].each do |role|
      if limit = row[role]
        r.set_role_limit role, limit.to_i
      end
    end

    repo.save r
  end
end

Given /^"(.*?)" signed up "(.*?)" for "(.*?)" as "(.*?)"$/ do |login, char_name, raid_location, role|
  current_user = find_user_by_login(login)
  character = Repository.for(Character).find_all_for_user(current_user).find {|c| c.name == char_name }
  raid = Repository.for(Raid).all.find {|r| r.where == raid_location }

  action = SignUpToRaid.new current_user
  action.run raid, character, role
end

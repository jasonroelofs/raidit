Given /^"(.*?)" is a raid leader for "(.*?)"$/ do |login, guild_name|
  guild = FindGuild.by_name(guild_name)
  user = FindUser.new.by_login(login)

  perm = Permission.new user: user, guild: guild, permissions: [:accept_signup, :unaccept_signup]

  Repository.for(Permission).save perm
end

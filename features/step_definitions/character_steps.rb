Given /^"(.*?)" has the following characters$/ do |login, table|
  repo = Repository.for(Character)
  current_user = Repository.for(User).find_by_login(login)

  table.hashes.each do |row|
    c = Character.new(
      region: row[:region],
      server: row[:server],
      game: row[:game],
      name: row[:name],
      user: current_user
    )

    repo.save c
  end
end
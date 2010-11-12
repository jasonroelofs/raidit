
Given %r{^there are the following characters for the current guild$} do |table|
  guild = get_guild("Exiled")

  table.hashes.each do |row|
    c = guild.characters.create(
      :name => row["name"],
      :race => row["race"],
      :klass => row["class"]
    )

    if row["taken"] == "true"
      c.user = User.create
      c.save
    end
  end
end

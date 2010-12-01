
Given %r{^there are the following characters for the current guild$} do |table|
  guild = get_guild("Exiled")

  table.hashes.each do |row|
    c = Factory(
      :character,
      :guild => guild,
      :name => row["name"],
      :race => row["race"],
      :class_name => row["class"]
    )

    if row["taken"] == "true"
      c.user = User.create
      c.save
    end
  end
end

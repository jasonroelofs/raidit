
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

Then %r{^I should see that "([^"]*)" is my main$} do |name|
  c = Character.find_by_name(name)
  c.is_main.should be_true
end

Given /^"(.*?)" has the following characters$/ do |login, table|
  repo = Repository.for(Character)
  current_user = Repository.for(User).find_by_login(login)

  table.hashes.each do |row|
    c = Character.new(
      name: row[:name],
      user: current_user,
      character_class: row[:character_class]
    )

    if row[:guild]
      guild = FindGuild.by_name row[:guild]
      c.guild = guild
    end

    repo.save c
  end
end

When /^I (follow|press) "(.*?)" for the character "(.*?)"$/ do |action, link_text, char_name|
  step %|I #{action} "#{link_text}" within "div[data-character-name=#{char_name.downcase}]"|
end

Then /^I should see the "(.*?)" icon$/ do |icon_name|
  assert page.has_css?("img[src='/assets/wow/#{icon_name}.png']")
end

When /^I select "(.*?)" from the (class|character) selector$/ do |name, type|
  page.find(".character-select a.select2-choice").click
  page.find(".select2-results .select2-result-label", :text => name).click
end

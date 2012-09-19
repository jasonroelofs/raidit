Then /^the current guild should be "(.*?)"$/ do |guild_name|
  steps %|Then I should see "#{guild_name}" within ".current-guild"|
end

When /^I change the guild to "(.*?)"$/ do |guild_name|
  steps %|Then I follow "#{guild_name}" within ".available-guilds"|
end

When /^I select "(.*?)" from the guild selector$/ do |guild_name|
  page.find(".guild-select a.select2-choice").click
  page.find(".select2-search .select2-input").set(guild_name)
  page.find(".select2-results .select2-result-label", :text => guild_name).click
end

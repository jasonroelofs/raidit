When %r{^I want to make a raid for "([^"]*)"$} do |date|
  date = Date.parse(date)
  visit("/raids/new?date=#{date.to_s(:default)}")
end

Then "I should not be able to add a raid" do
  page.should_not have_css(".add")
end

Given %r{^a raid exists for tomorrow named "([^"]*)"$} do |location|
  get_guild("Exiled").raids.create(
    :date => Date.tomorrow,
    :invite_time => "7:45 am",
    :start_time => "8:00 am",
    :location => location
  )
end

Given %r{^I am queued to "([^"]*)" with "([^"]*)"$} do |raid_name, char_name|
  char = @current_user.characters.find_by_name(char_name)
  raid = @current_guild.raids.find_by_location(raid_name)
  raid.queued.add!(char, char.main_role)
end

Then %r{^I should see "([^"]*)" is cancelled$} do |name|
  page.should have_css(".cancelled", :text => /#{name}/)
end

When %r{^I want to make a raid for "([^"]*)"$} do |date|
  date = Date.parse(date)
  visit("/raids/new?date=#{date.to_s(:default)}")
end

Then "I should not be able to add a raid" do
  page.should_not have_css(".add")
end

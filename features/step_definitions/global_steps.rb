Given /^I am at the home page$/ do
  step "I visit /"
end

When "I print the current page" do
  puts page.body
end

When "I debug" do
  require 'debugger'
  debugger
  true
end

When "I js debug" do
  page.driver.debug
end

Given /^today is "(.*?)"$/ do |date|
  Timecop.return
  Timecop.travel Date.parse(date)
end

Then /^"(.*?)" should not contain "(.*?)"$/ do |field, value|
  field = find_field(field)
  assert !field.first("option", :text => value)
end

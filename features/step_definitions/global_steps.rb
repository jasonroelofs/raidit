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

Given /^today is "(.*?)"$/ do |date|
  Timecop.travel Date.parse(date)
end

Then /^"(.*?)" should not contain "(.*?)"$/ do |field, value|
  field = find_field(field)
  assert !field.first("option", :text => value)
end

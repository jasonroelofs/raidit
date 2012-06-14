Given /^I am at the home page$/ do
  step "I visit /"
end

When "I print the page to stdout" do
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
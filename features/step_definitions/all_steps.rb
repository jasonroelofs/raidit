Given "I am at the sign in page" do
  visit("/")
end

When /^I wait (\d+) seconds$/ do |seconds|
  sleep seconds.to_i
end


Given "I am at the sign in page" do
  visit("/")
end

When /^I wait (\d+) seconds$/ do |seconds|
  sleep seconds.to_i
end

Given %r{^I am logged in as "([^"]*)"$} do |email|
  user = find_or_create_user(email, "test")

  steps %(
    Given I am at the sign in page
    And I fill in "#{email}" for "user_email"
    And I fill in "test" for "user_password"
    And I press "Sign in"
  )
end

Given %r{^today is "([^"]*)"$} do |date|
  Timecop.travel Date.parse(date)
end

def find_or_create_user(email, password)
  User.find_by_email(email) || 
    User.create(:email => email, :password => password, :password_confirmation => password)
end

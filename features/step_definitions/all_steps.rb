Given "I am at the sign in page" do
  visit("/users/sign_in")
end

When /^I wait (\d+) seconds$/ do |seconds|
  sleep seconds.to_i
end

When "I debug" do
  require 'ruby-debug'
  debugger
  true
end

When "I refresh" do 
  visit page.current_url
end

Given %r{^I am logged in as "([^"]*)"$} do |email|
  user = find_or_create_user(email, "testingzoo")
  
  @current_user = user
  @current_guild = get_guild("Exiled")

  steps %(
    Given I am at the sign in page
    And I fill in "#{email}" for "user_email"
    And I fill in "testingzoo" for "user_password"
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

def get_guild(name)
  Guild.find_by_name(name)
end

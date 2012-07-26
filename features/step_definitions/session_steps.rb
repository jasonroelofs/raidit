Given /^I am signed in as "(.*?)"$/ do |username|
  steps %{
    When I visit /login
    Then I fill in "#{username}" for "login"
    And I fill in "password" for "password"
    And I press "Log In"
  }
end

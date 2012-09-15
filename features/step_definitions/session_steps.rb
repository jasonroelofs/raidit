Given /^I am signed in as "(.*?)"$/ do |username|
  steps %{
    When I visit /login
    Then I fill in "#{username}" for "Login"
    And I fill in "password" for "Password"
    And I press "Log In"
  }
end

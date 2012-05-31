Given /^I am signed in as "(.*?)"$/ do |arg1|
  steps %{
    When I visit /login
    Then I fill in "jason" for "login"
    And I fill in "password" for "password"
    And I press "Log In"
  }
end

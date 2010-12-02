@users
Feature: Viewing API key and information

Scenario: Non admins can't get to api page
  Given I am logged in as "user@raidit.org"
  Then I should not see "Admin"

  When I visit "/admin/api"
  Then I should see "Monday"

Scenario: Admin can get to api page
  Given I am logged in as "jason@raidit.org"
  Then I should see "Admin"

  When I follow "Admin"
  Then I should see "Users"
  And I should see "Raids"
  And I should see "Event Logs"
  And I should see "API"

  When I follow "API"
  Then I should see "Event Logs"

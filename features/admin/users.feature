@users
Feature: Users management

Scenario: Non admins can't get to user management
  Given I am logged in as "user@raidit.org"
  Then I should not see "Admin"

  When I visit "/admin"
  Then I should see "Monday"

Scenario: Admin can get to Users management
  Given I am logged in as "jason@raidit.org"
  Then I should see "Admin"

  When I follow "Admin"
  Then I should see "Users"
  And I should see "Raids"
  And I should see "Event Logs"
  And I should see "API"

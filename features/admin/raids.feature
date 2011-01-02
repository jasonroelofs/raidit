@users
Feature: Raid management and history

Scenario: Non admins can't get to raid management
  Given I am logged in as "user@raidit.org"
  Then I should not see "Admin"

  When I visit "/admin/raids"
  Then I should see "Monday"

Scenario: Admin can get to Raid management
  Given I am logged in as "jason@raidit.org"
  Then I should see "Admin"

  When I follow "Admin"
  Then I should see "Users"
  And I should see "Raids"
  And I should see "API"

  When I follow "Raids"
  Then I should see "Users"

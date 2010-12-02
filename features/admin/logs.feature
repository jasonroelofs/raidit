@users
Feature: Viewing Event logs

Scenario: Non admins can't get to logs page
  Given I am logged in as "user@raidit.org"
  Then I should not see "Admin"

  When I visit "/admin/logs"
  Then I should see "Monday"

Scenario: Admin can get to logs page
  Given I am logged in as "jason@raidit.org"
  Then I should see "Admin"

  When I follow "Admin"
  Then I should see "Users"
  And I should see "Raids"
  And I should see "Event Logs"
  And I should see "API"

  When I follow "Event Logs"
  Then I should see "Event Logs"

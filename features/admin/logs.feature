@users
Feature: Viewing Event logs

Scenario: Non admins can't get to logs page
  Given I am logged in as "user@raidit.org"
  Then I should not see "Admin"

  When I visit "/admin/logs/12"
  Then I should see "Monday"

@raids @event_logs
Scenario: Admin can get to logs page
  Given I am logged in as "jason@raidit.org"
  Then I should see "Admin"

  When I follow "Admin"
  Then I should see "Users"
  And I should see "Raids"
  And I should see "API"

  When I follow "Raids"
  And I follow "Logs" for the raid to "ICC"

  Then I should see "Event Logs for ICC at 2010/11/01"

  And I should see "2010/10/30 4:40 am"
  And I should see "Mage-man"
  And I should see "accepted Warrior-girl"

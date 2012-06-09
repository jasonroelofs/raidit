Feature: Scheduling Raids

Scenario: A user can schedule a one-time raid
  Given I am signed in as "jason"
  And I am at the home page
  When I follow "Raids"
  And I follow "Schedule a Raid"
  Then I should see "Schedule a Raid"

  When I fill in "ICC" for "where"
  And I fill in "2012/06/04" for "when"
  And I fill in "20:00" for "start"
  And I press "Schedule"

  Then I should see "ICC on June 4, 2012"
  And I should see "8:00 PM Server"
  And I should see "Invites start at 7:45 PM Server"

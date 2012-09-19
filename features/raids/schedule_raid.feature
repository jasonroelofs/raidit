Feature: Scheduling Raids

Scenario: A regular user cannot schedule a raid
  Given I am signed in as "raider"
  And I am at the home page
  When I follow "Raids"
  Then I should not see "Schedule a Raid"

Scenario: A raid leader can schedule a one-time raid
  Given I am signed in as "raid_leader"
  And I am at the home page
  When I follow "Raids"
  And I follow "Schedule a Raid"
  Then I should see "Schedule a Raid"

  When I fill in "ICC" for "Where"
  And I fill in "2012/06/04" for "When"
  And I fill in "20:00" for "Start at"
  And I press "Schedule"

  Then I should see "ICC June 4, 2012 8:00 PM Server 7:45 PM Server"

Scenario: A user can add role limits to a raid
  Given I am signed in as "raid_leader"
  And I am at the home page
  When I follow "Raids"
  And I follow "Schedule a Raid"
  Then I should see "Schedule a Raid"

  When I fill in "ICC" for "Where"
  And I fill in "2012/06/04" for "When"
  And I fill in "20:00" for "Start"

  And I fill in "10" for "Tank"
  And I fill in "5" for "Healer"
  And I fill in "12" for "Dps"
  And I press "Schedule"

  Then I should see "ICC June 4, 2012 8:00 PM Server 7:45 PM Server 10 5 12"

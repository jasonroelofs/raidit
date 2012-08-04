Feature: Scheduling Raids

Scenario: A regular user cannot schedule a raid
  Given I am signed in as "raider"
  And I am at the home page
  When I follow "Raids"
  Then I should not see "Schedule a Raid"

Scenario: A raid leader can schedule a one-time raid
  Given I am signed in as "jason"
  And "jason" is a raid leader for "Exiled"
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

Scenario: A user can add role limits to a raid
  Given I am signed in as "jason"
  And "jason" is a raid leader for "Exiled"
  And I am at the home page
  When I follow "Raids"
  And I follow "Schedule a Raid"
  Then I should see "Schedule a Raid"

  When I fill in "ICC" for "where"
  And I fill in "2012/06/04" for "when"
  And I fill in "20:00" for "start"

  And I fill in "10" for "tank"
  And I fill in "5" for "heal"
  And I fill in "12" for "dps"
  And I press "Schedule"

  Then I should see "ICC on June 4, 2012"
  And I should see "8:00 PM Server"
  And I should see "Invites start at 7:45 PM Server"
  And I should see "Tanks: 10"
  And I should see "Healers: 5"
  And I should see "DPS: 12"

Feature: Viewing the Raid Calendar

Scenario: User with characters sees calendar as home page
  Given "raider" has the following characters
    | name    | guild  |
    | Weemuu  | Exiled |
  When I am signed in as "raider"
  Then I should see a calendar for the next 4 weeks

Scenario: A User can see raids for his guild on the calendar
  Given "raider" has the following characters
    | name    | guild  |
    | Weemuu  | Exiled |
  And today is "2012/04/01"
  And "Exiled" has scheduled the following raids
    | where       | when       | start | invite_offset |
    | ICC         | 2012/04/01 | 20:00 | 15            |
    | Firelands   | 2012/04/08 | 21:00 | 30            |
  And I am signed in as "raider"

  Then I should see "ICC" within "td[data-date='2012/04/01']"
  And I should see "7:45 PM" within "td[data-date='2012/04/01']"
  And I should see "Firelands" within "td[data-date='2012/04/08']"
  And I should see "8:30 PM" within "td[data-date='2012/04/08']"
  And I should not see "Molten Core"

Scenario: A User can change to a different guild to see that guild's calendar
  Given "raider" has the following characters
    | name    | guild  |
    | Weemuu  | Exiled |
    | Panduu  | MindCrush |
  And today is "2012/04/01"
  And "Exiled" has scheduled the following raids
    | where       | when       | start | invite_offset |
    | ICC         | 2012/04/01 | 20:00 | 15            |
    | Firelands   | 2012/04/08 | 21:00 | 30            |
  And "MindCrush" has scheduled the following raids
    | where       | when       | start | invite_offset |
    | Shadowpan   | 2012/04/03 | 19:00 | 15            |
    | BWL         | 2012/04/04 | 19:00 | 15            |
  When I am signed in as "raider"

  Then I should see "ICC"
  And I should see "Firelands"
  And I should not see "Shadowpan"
  And I should not see "BWL"
  And the current guild should be "Exiled"

  When I change the guild to "MindCrush"

  Then I should not see "ICC"
  And I should not see "Firelands"
  And I should see "Shadowpan"
  And I should see "BWL"
  And the current guild should be "MindCrush"

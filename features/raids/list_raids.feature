Feature: Listing Raids

Scenario: A user can see raids he has scheduled
  Given I am signed in as "raid_leader"
  And "raid_leader" has the following characters
    | name    | guild  |
    | Weemuu  | Exiled |
  And I am at the home page
  And "Exiled" has scheduled the following raids
    | where     | when        | start | invite_offset |
    | ICC       | 2012/07/01  | 20:00 | 15            |
    | Firelands | 2012/07/02  | 21:00 | 30            |

  When I follow "Raids"
  Then I should see "ICC July 1, 2012 8:00 PM Server 7:45 PM Server"
  And I should see "Firelands July 2, 2012 9:00 PM Server 8:30 PM Server"

Scenario: A raider can see raids for his guild
  Given I am signed in as "raider"
  And "raid_leader" has the following characters
    | name    | guild  |
    | Weemuu  | Exiled |
  And "raider" has the following characters
    | name    | guild  |
    | Phouchg | Exiled |

  And "Exiled" has scheduled the following raids
    | where     | when        | start | invite_offset |
    | ICC       | 2012/07/01  | 20:00 | 15            |
    | Firelands | 2012/07/02  | 21:00 | 30            |

  When I follow "Raids"
  Then I should see "ICC July 1, 2012"
  And I should see "Firelands July 2, 2012"

Scenario: A user can see raid list for the current guild
  Given "raider" has the following characters
    | name    | guild  |
    | Weemuu  | Exiled |
    | Panduu  | MindCrush |
  And "Exiled" has scheduled the following raids
    | where       | when       | start | invite_offset |
    | ICC         | 2012/07/01 | 20:00 | 15            |
    | Firelands   | 2012/07/02 | 21:00 | 30            |
  And "MindCrush" has scheduled the following raids
    | where       | when       | start | invite_offset |
    | Shadowpan   | 2012/07/03 | 19:00 | 15            |
    | BWL         | 2012/07/04 | 19:00 | 15            |
  And I am signed in as "raider"

  When I follow "Raids"
  Then the current guild should be "Exiled"
  And I should see "ICC July 1, 2012"
  And I should see "Firelands July 2, 2012"
  And I should not see "Shadowpan July 3, 2012"
  And I should not see "BWL July 4, 2012"

  When I change the guild to "MindCrush"

  Then I should not see "ICC July 1, 2012"
  And I should not see "Firelands July 2, 2012"
  And I should see "Shadowpan July 3, 2012"
  And I should see "BWL July 4, 2012"

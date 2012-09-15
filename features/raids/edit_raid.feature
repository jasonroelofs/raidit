Feature: Editing Raids

Scenario: A raider cannot edit a raid
  Given I am signed in as "raider"
  And I am at the home page
  And "Exiled" has scheduled the following raids
    | where     | when        | start | invite_offset |
    | ICC       | 2012/07/01  | 20:00 | 15            |
  When I follow "Raids"
  Then I should not see "Edit"
  And I should see "View"

Scenario: A raid leader can edit a guild's raid
  Given I am signed in as "raid_leader"
  And I am at the home page
  And "Exiled" has scheduled the following raids
    | where     | when        | start | invite_offset |
    | ICC       | 2012/07/01  | 20:00 | 15            |

  When I follow "Raids"
  And I follow "Edit"

  Then I should see "Edit Raid"

  When I fill in "Dragon Soul" for "Where"
  And I fill in "2012/07/15" for "When"
  And I fill in "17:30" for "Start at"

  And I press "Update Raid"

  Then I should see "Your Raids"
  And I should see "Dragon Soul on July 15, 2012"
  And I should see "5:30 PM Server"

Feature: Viewing the Raid Calendar

Background:
  Given "jason" has the following characters
    | game | region | server    | name    |
    | wow  | US     | Detheroc  | Weemuu  |

Scenario: User with characters sees calendar as home page
  When I am signed in as "jason"
  Then I should see "Raid Calendar"
  And I should see a calendar for the next 4 weeks

Scenario: Users can see raids on the calendar they own
  Given today is "2012/04/01"
  When "jason" has scheduled the following raids
    | where       | when       | start | invite_offset | tank | heal | dps |
    | ICC         | 2012/04/01 | 20:00 | 15            | 10   | 1    | 3   |
    | Firelands   | 2012/04/08 | 21:00 | 30            | 3    | 10   | 8   |
    | Molten Core | 2012/03/28 | 21:00 | 30            | 1    | 1    | 4   |
  When I am signed in as "jason"

  Then I should see "7:45 PM ICC" within "td[data-date='2012/04/01']"
  And I should see "14" within "td[data-date='2012/04/01']"

  And I should see "8:30 PM Firelands" within "td[data-date='2012/04/08']"
  And I should see "21" within "td[data-date='2012/04/08']"

  And I should not see "Molten Core"

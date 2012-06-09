Feature: Listing Raids

Scenario: A user can see raids he has scheduled
  Given I am signed in as "jason"
  And I am at the home page
  And "jason" has scheduled the following raids
    | where     | when        | start | invite_offset |
    | ICC       | 2012/07/01  | 20:00 | 15            |
    | Firelands | 2012/07/02  | 21:00 | 30            |

  When I follow "Raids"
  Then I should see "ICC on July 1, 2012"
  And I should see "8:00 PM Server"
  And I should see "Invites start at 7:45 PM Server"

  And I should see "Firelands on July 2, 2012"
  And I should see "9:00 PM Server"
  And I should see "Invites start at 8:30 PM Server"

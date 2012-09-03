Feature: User can add a character

Scenario: The user can add his / her first character to the account
  Given I am signed in as "raid_leader"
  And I am at the home page
  When I follow "Characters"

  Then I should see "Add A Character"
  When I fill in "Weemoo" for "name"
  And I press "Add Character"

  Then I should see "Weemoo"


Scenario: User can add another character to the account
  Given I am signed in as "raid_leader"
  And I am at the home page
  And "raid_leader" has the following characters
    | name    |
    | Weemuu  |

  When I follow "Characters"
  And I follow "Add New Character"

  Then I should see "Add A Character"
  When I fill in "Krood" for "name"
  And I press "Add Character"

  Then I should see "Weemuu"
  And I should see "Krood"

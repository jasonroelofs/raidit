@users @characters
Feature: Add notes to a queuing

Scenario: User can add notes to his characters
  Given I am logged in as "user@raidit.org"
  And a raid exists for tomorrow named "The Raid"

  And I am queued to "The Raid" with "Priest"

  When I follow "Calendar"
  And I follow "The Raid"

  When I follow "Note"
  And I fill in "note" with "This is a note, man"
  And I press "Add Note"
  And I wait 2 seconds

  Then "Priest" should have the following notes
    | raid | by | note|
    | The Raid | Priest | This is a note, man |

Scenario: Raid leader can add notes to any character
  Given I am logged in as "leader@raidit.org"
  And a raid exists for tomorrow named "The Raid"

  And I am queued to "The Raid" with "Warrior"
  And "user@raidit.org" is queued to "The Raid" with "Priest"
  And "jason@raidit.org" is queued to "The Raid" with "Mage"

  When I follow "Calendar"
  And I follow "The Raid"

  When I follow "Note" within "#dps"
  And I fill in "note" with "This is a note, man"
  And I press "Add Note"
  And I wait 2 seconds

  Then "Mage" should have the following notes
    | raid | by | note|
    | The Raid | Warrior | This is a note, man |

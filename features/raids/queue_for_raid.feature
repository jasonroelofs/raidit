@users
Feature: Users can queue for a raid

Scenario: Handles where user doesn't have any characters
  Given I am logged in as "user@raidit.org"
  And a raid exists for tomorrow named "The Raid"

  When I follow "Calendar"
  And I follow "The Raid"
  Then I should see "You don't have any characters"
  And I should see "Find your character(s) now"

@characters
Scenario: Users can queue a main character
  Given I am logged in as "jason@raidit.org"
  And a raid exists for tomorrow named "The Raid"

  When I follow "Calendar"
  And I follow "The Raid"

  Then I should see "Queue With Mage"
  When I press "Queue With Mage"

  Then I should see "Mage" within "#dps"
  And I should see "Mage" is queued

@characters
Scenario: Users can choose an alt character and role
  Given I am logged in as "jason@raidit.org"
  And a raid exists for tomorrow named "The Raid"

  When I follow "Calendar"
  And I follow "The Raid"

  Then I should see "Queue with another"
  When I follow "Queue with another"
  And I select "DK" from "Character:"
  And I select "Healer" from "Role:"
  And I press "Add to Queue"

  Then I should see "DK" within "#healer"
  And I should see "DK" is queued

@characters
Scenario: User can cancel signup from any queue
  Given I am logged in as "user@raidit.org"
  And a raid exists for tomorrow named "The Raid"
  And I am queued to "The Raid" with "Priest"

  When I follow "Calendar"
  And I follow "The Raid"

  Then I should see "Priest" within "#healer"

  When I follow "Cancel" within ".actions"
  Then I should see "Priest" within "#healer"
  And I should see "Priest" is cancelled

@characters
Scenario: Cannot queue for raids in the past
  Given I am logged in as "user@raidit.org"
  And a raid exists for yesterday named "The Raid"
  And I am queued to "The Raid" with "Priest"

  When I follow "Calendar"
  And I follow "The Raid"

  Then I should not see "Queue With Priest"

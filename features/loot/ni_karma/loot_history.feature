@users @characters @ni_karma
Feature: Can see the loot history for an individual character

Scenario: View loot history
  Given I am logged in as "jason@raidit.org"
  When I follow "Admin"
  And I follow "Loot"
  When I attach the file "LootFile.lua" to "file"
  And I press "Upload"
  And the loot upload processor runs

  When I follow "Karma"
  And I follow "DK"

  Then I should see "Karma History for DK"
  And I should see "Start of Raid"
  And I should see "Boss Kill"
  And I should see "Belt of the Tenebrous Mist"

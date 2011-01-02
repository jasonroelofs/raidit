@users
Feature: Upload / Download loot files

Scenario: RL can see loot management
  Given I am logged in as "leader@raidit.org"
  Then I should see "Admin"

  When I follow "Admin"
  Then I should see "Loot"
  And I should see "Loot System"

Scenario: Raid Leader can upload a loot file, then download it
  Given I am logged in as "leader@raidit.org"
  When I follow "Admin"
  And I follow "Loot"
  Then I should see "Loot System"

  When I attach the file "LootFile.lua" to "file"
  And I press "Upload"

  Then I should see "File uploaded"
  And I should see "LootFile.lua"

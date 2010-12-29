@users @characters @ni_karma
Feature: System parses out and uses Ni Karma loot file

Scenario: Uploading and processing ni karma file sets current, lifetime, and history
  Given I am logged in as "jason@raidit.org"
  When I follow "Admin"
  And I follow "Loot"
  When I attach the file "loot_file.lua" to "file"
  And I press "Upload"

  Then I should see "File uploaded"
  And I should see "loot_file.lua"

  When the loot upload processor runs
  And I follow "Karma"
  Then I should see the following karma values
    | character | current | lifetime  |
    | Mage      | 0       | 15        |
    | DK        | 25      | 65        |
    | Warrior   | 10      | 10        |
    | Priest    | 20      | 20        |

@users @characters
Feature: User can assign guild characters to account

Scenario: User can search and add their character(s) to their account
  Given I am logged in as "jason@raidit.org"
  And there are the following characters for the current guild
    | name    | race    | class   | taken |
    | Weemuu  | Troll   | Mage    | false |
    | Weemoo  | Tauren  | Shaman  | false |
    | Wonko   | Tauren  | Warrior | true |

  When I follow "My Characters"
  And I follow "Add Character"

  When I fill in "Wee" for "Character Name"
  And I wait 1 second

  Then I should see "Weemuu"
  And I should see "Weemoo"
  And I should not see "Wonko"

  When I fill in "muu" for "Character Name"
  And I wait 1 second

  Then I should see "Weemuu"
  And I should not see "Weemoo"
  And I should not see "Wonko"

  When I follow "Weemuu"
  Then I should see "My Characters"
  And I should see "Weemuu"
  
Scenario: First character is auto-main'd
  Given I am logged in as "leader@raidit.org"
  When I follow "My Characters"
  Then I should see "Warrior" within ".main"
  And I should see that "Warrior" is my main

Scenario: Can 'main' a character
  Given I am logged in as "jason@raidit.org"
  And I follow "My Characters"
  Then I should see "Mage" within ".main"
  And I should see "DK" within ".alts"

  When I follow "Make Main"
  Then I should see "DK" within ".main"
  And I should see "Mage" within ".alts"

Scenario: Can change the main role of a character
  Given I am logged in as "jason@raidit.org"
  And I follow "My Characters"

  Then the "character[main_role]" field within ".alts" should contain "tank"

  When I select "DPS" from "character[main_role]" within ".alts"
  And I press "Update"

  Then the "character[main_role]" field within ".alts" should contain "dps"

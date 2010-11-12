Feature: User can assign guild characters to account

Scenario: User can see all unselected charcters for the guild and choose one to add
  Given I am logged in as "jason@raidit.org"
  And there are the following characters for the current guild
    | name    | race    | class   | taken |
    | Weemuu  | Troll   | Mage    | false |
    | Weemoo  | Tauren  | Shaman  | false |
    | Wonko   | Tauren  | Warrior | true |

  When I follow "My Characters"
  And I follow "Add Character"

  Then I should see "Weemuu"
  And I should see "Weemoo"
  And I should not see "Wonko"

  When I follow "Weemuu"
  Then I should see "My Characters"
  And I should see "Weemuu"
  

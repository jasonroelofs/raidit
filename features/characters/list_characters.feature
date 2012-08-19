Feature: Listing a user's characters

  Scenario: User sees characters by guild

  Scenario: User sees his unguilded characters
    Given I am signed in as "raid_leader"
    And I am at the home page
    And "raid_leader" has the following characters
      | game | region | server    | name    | character_class |
      | wow  | US     | Detheroc  | Weemuu  | Mage            |

    When I follow "Characters"
    Then I should see "Unguilded"
    And I should see "Weemuu US - Detheroc" within ".unguilded"

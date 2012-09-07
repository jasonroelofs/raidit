Feature: User can add a character

  Scenario: The user can add his / her first character to the account
    Given I am signed in as "raid_leader"
    And I am at the home page
    When I follow "Characters"

    Then I should see "Add A Character"
    When I fill in "Weemoo" for "name"
    And I select "Shaman" from "character_class"
    And I press "Add Character"

    Then I should see "Weemoo" within ".unguilded"
    And I should see the "shaman" icon

  Scenario: User can add another character to the account
    Given I am signed in as "raid_leader"
    And I am at the home page
    And "raid_leader" has the following characters
      | name    | character_class |
      | Weemuu  | mage            |

    When I follow "Characters"
    And I follow "Add New Character"

    Then I should see "Add A Character"
    When I fill in "Krood" for "name"
    And I select "Druid" from "character_class"
    And I press "Add Character"

    Then I should see "Weemuu" within ".unguilded"
    And I should see "Krood" within ".unguilded"
    And I should see the "druid" icon

  Scenario: User can auto-add character to an existing guild
    Given I am signed in as "raid_leader"
    And I am at the home page
    And "raid_leader" has the following characters
      | name    | character_class | guild   |
      | Weemuu  | mage            | Exiled  |

    When I follow "Characters"
    And I follow "Add New Character"

    When I fill in "Panduu" for "name"
    And I select "Monk" from "character_class"
    And I select "Exiled" from "guild_id"
    And I press "Add Character"

    Then I should see "Panduu" within ".guilded.exiled"


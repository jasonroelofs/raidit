Feature: User can add a character

  Scenario: The user can add his / her first character to the account
    Given I am signed in as "raid_leader"
    And I am at the home page
    When I follow "Characters"

    Then I should see "Add A Character"
    When I fill in "Weemoo" for "Name"
    And I select "Shaman" from "Character class"
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
    When I fill in "Krood" for "Name"
    And I select "Druid" from "Character class"
    And I press "Add Character"

    Then I should see "Weemuu" within ".unguilded"
    And I should see "Krood" within ".unguilded"
    And I should see the "druid" icon

  @javascript
  Scenario: User can auto-add character to an existing guild
    Given I am signed in as "raid_leader"
    And I am at the home page
    And "raid_leader" has the following characters
      | name    | character_class | guild   |
      | Weemuu  | mage            | Exiled  |

    When I follow "Characters"
    And I follow "Add New Character"

    When I fill in "Panduu" for "Name"
    And I select "Monk" from the class selector
    And I select "Exiled" from the guild selector
    And I press "Add Character"

    Then I should see "Panduu" within ".exiled"

  @javascript
  Scenario: User can add character to guild he's not yet a member of
    Given I am signed in as "raider"
    And I am at the home page
    And "raid_leader" has the following characters
      | name    | character_class | guild   |
      | Weemuu  | mage            | Exiled  |
    When I follow "Characters"

    And I fill in "Panduu" for "Name"
    And I select "Monk" from the class selector
    And I select "Exiled" from the guild selector
    And I press "Add Character"

    Then I should see "Panduu" within ".exiled"

  @javascript
  Scenario: User can start a new guild from the Add Character screen
    Given I am signed in as "raider"
    And I am at the home page
    When I follow "Characters"

    And I fill in "Panduu" for "Name"
    And I select "Monk" from the class selector
    And I select "[Add Your Guild]" from the guild selector

    Then I should see "Add a Guild"
    When I fill in "US" for "Region"
    And I fill in "Detheroc" for "Server"
    And I fill in "Weemopolis" for "character_guild_name"

    And I press "Add Character"

    Then I should see "Panduu" within ".weemopolis"

  Scenario: Handles error cases
    Given I am signed in as "raid_leader"
    And I am at the home page
    And I follow "Characters"

    When I press "Add Character"

    Then I should see "can't be blank"
    And I should see "Add A Character!"

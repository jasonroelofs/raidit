Feature: Adding a Guild

  @javascript
  Scenario: User can start a new guild when adding a character
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

  @javascript
  Scenario: User can set up a new guild when editing an existing character
    Given I am signed in as "raid_leader"
    And I am at the home page
    And "raid_leader" has the following characters
      | name    | guild   |
      | Weemuu  | Exiled  |

    When I follow "Characters"
    And I follow "Edit" within ".exiled"
    And I select "[Add Your Guild]" from the guild selector

    Then I should see "Add a Guild"
    When I fill in "US" for "Region"
    And I fill in "Detheroc" for "Server"
    And I fill in "Weemopolis" for "character_guild_name"
    And I press "Update Character"

    Then I should see "Weemuu" within ".weemopolis"

Feature: Editing an existing character

  Scenario: Can change name and class
    Given I am signed in as "raid_leader"
    And I am at the home page
    And "raid_leader" has the following characters
      | name    | guild   |
      | Weemuu  | Exiled  |

    When I follow "Characters"
    And I follow "Edit" within ".guilded.exiled"

    Then I should see "Edit Character"
    When I fill in "Weeboo" for "Name"
    And I select "Shaman" from "Character class"
    And I press "Update Character"

    Then I should see "Weeboo" within ".guilded.exiled"
    And I should not see "Weemuu"
    And I should see the "shaman" icon

  Scenario: Handles error cases
    Given I am signed in as "raid_leader"
    And I am at the home page
    And "raid_leader" has the following characters
      | name    | guild   |
      | Weemuu  | Exiled  |

    When I follow "Characters"
    And I follow "Edit" within ".guilded.exiled"
    And I fill in "" for "Name"
    And I press "Update Character"

    Then I should see "can't be blank"
    And I should see "Edit Character"

  @javascript
  Scenario: Can change guild of character
    Given I am signed in as "raid_leader"
    And I am at the home page
    And "raid_leader" has the following characters
      | name    | guild   |
      | Weemuu  | Exiled  |
      | Johnson | Mind Crush |

    When I follow "Characters"
    And I follow "Edit" within ".guilded.exiled"
    And I select "Mind Crush" from the guild selector
    And I press "Update Character"

    Then I should see "Weemuu" within ".guilded.mindcrush"

  @javascript
  Scenario: Can set up a new guild for an existing character
    Given I am signed in as "raid_leader"
    And I am at the home page
    And "raid_leader" has the following characters
      | name    | guild   |
      | Weemuu  | Exiled  |

    When I follow "Characters"
    And I follow "Edit" within ".guilded.exiled"
    And I select "[Add Your Guild]" from the guild selector

    Then I should see "Add a Guild"
    When I fill in "US" for "Region"
    And I fill in "Detheroc" for "Server"
    And I fill in "Weemopolis" for "character_guild_name"
    And I press "Update Character"

    Then I should see "Weemuu" within ".guilded.weemopolis"

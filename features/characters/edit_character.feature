Feature: Editing an existing character

  Scenario: Can change name and class
    Given I am signed in as "raid_leader"
    And I am at the home page
    And "raid_leader" has the following characters
      | name    | guild   |
      | Weemuu  | Exiled  |

    When I follow "Characters"
    And I follow "Edit" within ".exiled"

    Then I should see "Edit Character"
    When I fill in "Weeboo" for "Name"
    And I select "Shaman" from "Character class"
    And I press "Update Character"

    Then I should see "Weeboo" within ".exiled"
    And I should not see "Weemuu"
    And I should see the "shaman" icon

  Scenario: Handles error cases
    Given I am signed in as "raid_leader"
    And I am at the home page
    And "raid_leader" has the following characters
      | name    | guild   |
      | Weemuu  | Exiled  |

    When I follow "Characters"
    And I follow "Edit" within ".exiled"
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
    And I follow "Edit" within ".exiled"
    And I select "Mind Crush" from the guild selector
    And I press "Update Character"

    Then I should see "Weemuu" within ".mindcrush"


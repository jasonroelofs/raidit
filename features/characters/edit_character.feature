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

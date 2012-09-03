Feature: Signing up to a Raid

  Background:
    Given I am signed in as "raid_leader"
    And today is "2012/07/01"
    And "Exiled" has scheduled the following raids
      | where     | when        | start | invite_offset |
      | ICC       | 2012/07/01  | 20:00 | 15            |

  Scenario: User must have a character
    When I am at the home page
    And I follow "ICC"
    Then I should see "You need a character to sign up to raid"

  Scenario: User signs up to a raid, is "Available" for selected role
    When "raid_leader" has the following characters
      | name    |
      | Weemuu  |
    And I am at the home page
    And I follow "ICC"

    Then I should see "Sign Up for this Raid"

    When I select "Weemuu" from "character_id"
    And I select "DPS" from "role"
    And I press "Sign Up"

    Then I should see "Weemuu" within ".available .dps"

    And I should not see "Sign Up for this Raid"
    And I should not see "You need a character to sign up to raid"
    And I should see "You have no more characters to sign up!"

  Scenario: User can sign up multiple of his own characters
    When "raid_leader" has the following characters
      | name    |
      | Weemuu  |
      | Wonko   |
      | Stabby  |

    And I am at the home page
    And I follow "ICC"

    Then I should see "Sign Up for this Raid"

    When I select "Weemuu" from "character_id"
    And I select "DPS" from "role"
    And I press "Sign Up"

    Then "character_id" should not contain "Weemuu"

    When I select "Wonko" from "character_id"
    And I select "Tank" from "role"
    And I press "Sign Up"

    Then "character_id" should not contain "Weemuu"
    And "character_id" should not contain "Wonko"

    When I select "Stabby" from "character_id"
    And I select "Healer" from "role"
    And I press "Sign Up"

    Then I should see "Weemuu" within ".available .dps"
    And I should see "Wonko" within ".available .tank"
    And I should see "Stabby" within ".available .healer"

    And I should not see "Sign Up for this Raid"

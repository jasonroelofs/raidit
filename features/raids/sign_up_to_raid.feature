Feature: Signing up to a Raid

  Background:
    Given I am signed in as "jason"
    And today is "2012/07/01"
    And "jason" has scheduled the following raids
      | where     | when        | start | invite_offset |
      | ICC       | 2012/07/01  | 20:00 | 15            |

  Scenario: User must have a character
    When I am at the home page
    And I follow "ICC"
    Then I should see "You need a character to sign up to raid"

  Scenario: User signs up to a raid, is "Available"
    When "jason" has the following characters
      | game | region | server    | name    |
      | wow  | US     | Detheroc  | Weemuu  |
    And I am at the home page
    And I follow "ICC"

    Then I should see "Sign Up for this Raid"

    When I select "Weemuu" from "character_id"
    And I press "Sign Up"

    Then I should see "Weemuu" within ".available"
    And I should not see "Sign Up for this Raid"
    And I should not see "You need a character to sign up to raid"
    And I should see "You have no more characters to sign up!"

  Scenario: User can sign up multiple of his own characters
    When "jason" has the following characters
      | game | region | server    | name    |
      | wow  | US     | Detheroc  | Weemuu  |
      | wow  | US     | Detheroc  | Wonko   |
      | wow  | US     | Detheroc  | Stabby  |

    And I am at the home page
    And I follow "ICC"

    Then I should see "Sign Up for this Raid"

    When I select "Weemuu" from "character_id"
    And I press "Sign Up"

    And I select "Wonko" from "character_id"
    And I press "Sign Up"

    And I select "Stabby" from "character_id"
    And I press "Sign Up"

    Then I should see "Weemuu" within ".available"
    And I should see "Wonko" within ".available"
    And I should see "Stabby" within ".available"

    And I should not see "Sign Up for this Raid"

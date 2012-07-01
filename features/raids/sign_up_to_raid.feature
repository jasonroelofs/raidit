Feature: Signing up to a Raid

  Background:
    Given I am signed in as "jason"
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

    When I select "Weemuu" from "character"
    And I press "Sign Up"

    Then I should see "Weemuu" within ".available"

@javascript
Feature: Commenting on Raid Signups

  Background:
    Given "Exiled" has scheduled the following raids
      | where     | when        | start | invite_offset |
      | ICC       | today       | 20:00 | 15            |
    And "raid_leader" has the following characters
      | name    | guild |
      | Weemuu  | Exiled |
    And "raider" has the following characters
      | name    | guild |
      | Panduu  | Exiled |
    And "raid_leader" signed up "Weemuu" for "ICC" as "dps"

  Scenario: User can comment on a signup
    Given I am signed in as "raider"
    And I am at the home page
    When I follow "ICC"
    And I click on the signup for "Weemuu"

    Then I should see "Comments" within ".signup-details.weemuu"
    When I fill in "Comment" with "Are you going to make it tonight?"
    And I press "Add Comment"

    When I click on the signup for "Weemuu"
    Then I should see "Are you going to make it tonight?" within ".signup-details .comments"

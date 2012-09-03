Feature: Managing Raid Signups

  Background:
    Given today is "2012/07/01"
    And "Exiled" has scheduled the following raids
      | where     | when        | start | invite_offset |
      | ICC       | 2012/07/01  | 20:00 | 15            |
    And "raid_leader" has the following characters
      | game | region | server    | name    |
      | wow  | US     | Detheroc  | Weemuu  |
    And "raid_leader" signed up "Weemuu" for "ICC" as "dps"

  Scenario: Raid leader can manage signup acceptance
    Given I am signed in as "raid_leader"
    When I am at the home page
    And I follow "ICC"

    # Available -> Accept
    Then I should see "Accept" within ".available .dps"

    When I follow "Accept"
    Then I should see "Weemuu" within ".accepted .dps"
    And I should see "Unaccept" within ".accepted .dps"

    # Doesn't skip over roles
    And I should not see "Weemuu" within ".accepted .healer"
    And I should not see "Weemuu" within ".accepted .tank"

    # Accept -> Available
    When I follow "Unaccept"
    Then I should see "Weemuu" within ".available .dps"
    And I should see "Accept" within ".available .dps"

    # Available -> Cancelled
    When I follow "Cancel"
    Then I should see "Weemuu" within ".cancelled .dps"
    And I should see "Enqueue" within ".cancelled .dps"
    And I should not see "Accept" within ".cancelled .dps"

    # Cancelled -> Available
    When I follow "Enqueue"
    Then I should see "Weemuu" within ".available .dps"
    And I should see "Accept" within ".available .dps"
    And I should see "Cancel" within ".available .dps"

    # Accepted -> Cancelled
    When I follow "Accept"
    And I follow "Cancel"
    Then I should see "Weemuu" within ".cancelled .dps"
    And I should see "Enqueue" within ".cancelled .dps"
    And I should not see "Accept" within ".cancelled .dps"

  Scenario: Raid leader cannot cancel signups they don't own
    Given I am signed in as "raid_leader"
    And "raider" has the following characters
      | game | region | server    | name     |
      | wow  | US     | Detheroc  | Phouchg  |
    And "raider" signed up "Phouchg" for "ICC" as "tank"
    When I am at the home page
    And I follow "ICC"

    Then I should not see "Cancel" within ".tank"

  Scenario: Raider can sign up but not accept
    Given I am signed in as "raider"
    And "raider" has the following characters
      | game | region | server    | name     |
      | wow  | US     | Detheroc  | Phouchg  |
    And "raider" signed up "Phouchg" for "ICC" as "tank"

    When I am at the home page
    And I follow "ICC"

    Then I should see "Weemuu"
    And I should see "Weemuu"
    And I should not see "Accept"
    And I should not see "Cancel" within ".available .dps"
    And I should see "Cancel" within ".available .tank"

  Scenario: Raider can cancel and requeue their characters
    Given I am signed in as "raider"
    And "raider" has the following characters
      | game | region | server    | name     |
      | wow  | US     | Detheroc  | Phouchg  |
    And "raider" signed up "Phouchg" for "ICC" as "tank"

    When I am at the home page
    And I follow "ICC"

    And I follow "Cancel"
    Then I should see "Phouchg" within ".cancelled"
    And I should see "Enqueue" within ".cancelled .tank"
    When I follow "Enqueue"
    Then I should see "Phouchg" within ".available"


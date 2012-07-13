Feature: Managing Raid Signups

  Background:
    Given I am signed in as "jason"
    And today is "2012/07/01"
    And "jason" has scheduled the following raids
      | where     | when        | start | invite_offset |
      | ICC       | 2012/07/01  | 20:00 | 15            |
    And "jason" has the following characters
      | game | region | server    | name    |
      | wow  | US     | Detheroc  | Weemuu  |

    And "jason" signed up "Weemuu" for "ICC"
    When I am at the home page
    And I follow "ICC"

  Scenario: Raid leader can manage signup acceptance
    # Available -> Accept
    Then I should see "Accept" within ".available"

    When I follow "Accept"
    Then I should see "Weemuu" within ".accepted"
    And I should see "Unaccept" within ".accepted"

    # Accept -> Available
    When I follow "Unaccept"
    Then I should see "Weemuu" within ".available"
    And I should see "Accept" within ".available"

    # Available -> Cancelled
    When I follow "Cancel"
    Then I should see "Weemuu" within ".cancelled"
    And I should see "Enqueue" within ".cancelled"
    And I should not see "Accept" within ".cancelled"

    # Cancelled -> Available
    When I follow "Enqueue"
    Then I should see "Weemuu" within ".available"
    And I should see "Accept" within ".available"
    And I should see "Cancel" within ".available"

    # Accepted -> Cancelled
    When I follow "Accept"
    And I follow "Cancel"
    Then I should see "Weemuu" within ".cancelled"
    And I should see "Enqueue" within ".cancelled"
    And I should not see "Accept" within ".cancelled"

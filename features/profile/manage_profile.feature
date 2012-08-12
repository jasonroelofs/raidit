Feature: User can manage their personal information

  Scenario: User can see their login and email on profile page
    Given I am signed in as "raid_leader"
    And I am at the home page
    When I follow "Profile"

    Then the "Login" field should contain "raid_leader"
    And the "Email" field should contain "raid_leader@raidit.org"

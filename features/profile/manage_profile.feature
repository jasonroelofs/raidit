Feature: User can manage their personal information

  Background:
    Given I am signed in as "raid_leader"
    And I am at the home page
    When I follow "Profile"

  Scenario: User can see their login and email on profile page
    Then the "Login" field should contain "raid_leader"
    And the "Email" field should contain "raid_leader@raidit.org"

  Scenario: User can change their login
    When I fill in "Login" with "new_user"
    And I press "Save"

    Then the "Login" field should contain "new_user"
    When I follow "Log Out"
    And I am signed in as "new_user"

    Then I should see "Profile"

  Scenario: User can change their password
    When I fill in "Current Password" with "password"
    When I fill in "New Password" with "newPass"
    And I fill in "Again" with "newPass"
    And I press "Save"

    When I follow "Log Out"
    And I follow "Log In"

    Then I fill in "raid_leader" for "login"
    And I fill in "newPass" for "password"
    And I press "Log In"
    Then I should see "Characters"

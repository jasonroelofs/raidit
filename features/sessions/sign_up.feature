Feature: User signs up for raidit

  Scenario: User can sign up for an account
    Given I am at the home page
    And I follow "Sign Up"
    Then I should see "Sign Up!"

    When I fill in "tester" for "Login"
    And I fill in "tester@example.com" for "Email"
    And I fill in "passwordy" for "Password"
    And I fill in "passwordy" for "Password confirmation"
    And I press "Sign Up"

    Then I should see "Raid Calendar"
    And I should see "Characters"

    # See that new login / password is saved
    When I follow "Log Out"
    And I follow "Log In"
    And I fill in "tester" for "login"
    And I fill in "passwordy" for "password"
    And I press "Log In"

    Then I should see "Characters"

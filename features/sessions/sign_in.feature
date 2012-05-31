Feature: User Signs In

Scenario: User can sign into the app
  Given I visit /login
  Then I should see "Login"
  And I should see "Password"

  When I fill in "jason" for "login"
  And I fill in "password" for "password"
  And I press "Log In"

  Then I should see "Characters"


Scenario: Unknown user sees error when trying to sign in
  Given I visit /login
  Then I should see "Login"
  And I should see "Password"

  When I fill in "raider" for "login"
  And I fill in "password" for "password"
  And I press "Log In"

  Then I should see "Login"
  And I should not see "Characters"

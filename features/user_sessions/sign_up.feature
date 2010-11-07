Feature: Users can sign up new accounts

Scenario: Sign up a new account
  Given I am at the sign in page
  When I follow "Sign up"

  Then I should see "Sign up"

  When I fill in "jason@raidit.org" for "Email"
  And I fill in "password" for "Password"
  And I fill in "password" for "Password confirmation"
  And I press "Sign up"

  Then I should see "jason@raidit.org"
  And I should see "Sign out"

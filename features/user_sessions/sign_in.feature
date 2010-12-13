@users
Feature: Users can sign in with existing accounts

@characters
Scenario: Log in as existing user
  Given I am logged in as "jason@raidit.org"
  Then I should see "jason@raidit.org"
  And I should see "Sign out"
  And I should see "My Characters"

Scenario: User with no characters is told as such
  Given I am logged in as "jason@raidit.org"
  Then I should see "jason@raidit.org"
  And I should see "You don't have any characters assigned"

Feature: Users can sign out of the system

Scenario: Sign out of system
  Given I am logged in as "jason@raidit.org"
  When I follow "Sign out"
  Then I should not see "jason@raidit.org"
  And I should not see "My Characters"

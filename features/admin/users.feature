@users @characters
Feature: Users management

Scenario: Non admins can't get to user management
  Given I am logged in as "user@raidit.org"
  Then I should not see "Admin"

  When I visit "/admin"
  Then I should see "Monday"

Scenario: Admin can get to Users management
  Given I am logged in as "jason@raidit.org"
  Then I should see "Admin"

  When I follow "Admin"
  Then I should see "Users"
  And I should see "Raids"
  And I should see "API"

Scenario: Admin sees users and what characters they have
  Given I am logged in as "jason@raidit.org"
  When I follow "Admin"

  And I should see "jason@raidit.org"
  And I should see "leader@raidit.org"
  And I should see "user@raidit.org"

  And I should see "Mage"
  And I should see "DK"
  And I should see "Warrior"
  And I should see "Priest"

Scenario: Admin can change a user's role
  Given I am logged in as "jason@raidit.org"
  When I follow "Admin"
  And I edit "leader@raidit.org"
  And I select "user" from "Role: "
  And I press "Submit"

  Then "leader@raidit.org" should be a user
  And "leader@raidit.org" should not be a raid leader

Scenario: Admin can unassign a character from a user
  Given I am logged in as "jason@raidit.org"
  When I follow "Admin"
  And I edit "jason@raidit.org"

  And I unassociate the character "DK"

  Then I should not see "DK" within ".characters"
  When I follow "My Characters"
  Then I should not see "DK"

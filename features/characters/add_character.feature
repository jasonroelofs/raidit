Feature: User can add a character

Scenario: The user can add his / her first character to the account
  Given I am signed in as "jason"
  And I am at the home page
  When I follow "Characters"

  Then I should see "Add A Character"
  When I follow "World of Warcraft"
  And I select "US" from "region"
  And I fill in "Kil'Jaeden" for "server"
  And I fill in "Weemoo" for "name"
  And I press "Add Character"

  Then I should see "You have the following Characters"
  And I should see "Weemoo"
  And I should see "US - Kil'Jaeden"

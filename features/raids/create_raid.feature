Feature: Managing Raids

Scenario: Can create a raid for a given day
  Given I am logged in as "jason@raidit.org"
  And today is "2010/11/01"
  When I want to make a raid for "2010/11/04"
  And I fill in "3:34 am" for "Invite Time"
  And I fill in "4:40 am" for "Start Time"
  And I fill in "Papa John's" for "Location"
  And I fill in "Cause we LOVE pizza" for "Description"
  And I press "Create Raid"

  Then I should see "Papa John's"
  And I should see "Invite: 3:34 am"
  And I should see "Start: 4:40 am"
  

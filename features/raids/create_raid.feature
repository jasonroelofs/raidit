@users
Feature: Creating Raids

Scenario: Admin can create a raid for a given day
  Given I am logged in as "jason@raidit.org"
  And today is "2010/11/01"
  When I want to make a raid for "2010/11/04"
  And I fill in "3:34 am" for "Invite Time"
  And I fill in "4:40 am" for "Start Time"
  And I fill in "Papa John's" for "Location"
  And I fill in "Cause we LOVE pizza" for "Description"
  And I fill in "10" for "Tanks"
  And I fill in "20" for "Healers"
  And I fill in "100" for "DPS"
  And I press "Create Raid"

  Then I should see "Papa John's"

  When I follow "Papa John's"
  Then I should see "Cause we LOVE pizza"
  And I should see "Raid Info"
  And I should see "0 / 10"
  And I should see "0 / 20"
  And I should see "0 / 100"

Scenario: Raid leaders can create raids
  Given I am logged in as "leader@raidit.org"
  And today is "2010/11/05"
  When I want to make a raid for "2010/11/16"
  And I fill in "3:34 am" for "Invite Time"
  And I fill in "4:40 am" for "Start Time"
  And I fill in "Papa John's" for "Location"
  And I fill in "Cause we LOVE pizza" for "Description"
  And I fill in "10" for "Tanks"
  And I fill in "20" for "Healers"
  And I fill in "100" for "DPS"
  And I press "Create Raid"

  Then I should see "Papa John's"

Scenario: RL can use default buttons for raid sizes
  Given I am logged in as "leader@raidit.org"
  And today is "2010/11/05"
  When I want to make a raid for "2010/11/16"
  And I fill in "3:34 am" for "Invite Time"
  And I fill in "4:40 am" for "Start Time"
  And I fill in "Papa John's" for "Location"
  And I fill in "Cause we LOVE pizza" for "Description"
  And I follow "10-man"
  And I press "Create Raid"

  When I follow "Papa John's"
  And I should see "0 / 2"
  And I should see "0 / 6"

  When I follow "Edit"
  And I follow "25-man"
  And I press "Update Raid"

  Then I should see "0 / 3"
  And I should see "0 / 6"
  And I should see "0 / 16"

Scenario: Users cannot create raids
  Given I am logged in as "user@raidit.org"
  Then I should not be able to add a raid 

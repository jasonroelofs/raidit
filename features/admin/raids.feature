@users
Feature: Raid management and history

Scenario: Non admins can't get to raid management
  Given I am logged in as "user@raidit.org"
  Then I should not see "Admin"

  When I visit "/admin/raids"
  Then I should see "Monday"

Scenario: Admin can get to Raid management
  Given I am logged in as "jason@raidit.org"
  Then I should see "Admin"

  When I follow "Admin"
  Then I should see "Users"
  And I should see "Raids"
  And I should see "API"

  When I follow "Raids"
  Then I should see "Users"

@raids
Scenario: Admin sees list of current and past raids
  Given I am logged in as "jason@raidit.org"
  And I follow "Admin"
  When I follow "Raids"
  Then I should see the following raids
    | date        | invite  | start   | where | 
    | 2010/11/01  | 7:45 pm | 8:00 pm | ICC   |
    | 2010/11/12  | 7:45 pm | 8:00 pm | Baradin Hold |
    | 2010/12/20  | 11:13 am| 11:14 am| Ken's Mom |

@raids
Scenario: Admin can view a raid
  Given I am logged in as "jason@raidit.org"
  And I follow "Admin"
  And I follow "Raids"

  When I follow "View" for the raid to "ICC"
  Then I should see "Raid Info"
  And I should see "ICC"
  And I should see "7:45 pm"
  And I should see "8:00 pm"


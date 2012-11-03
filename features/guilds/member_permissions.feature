Feature: Managing guild member permissions

  Scenario: Raider cannot view permissions of others
    Given "raid_leader" has the following characters
      | name    | guild       | is_main |
      | Stabby  | Exiled      | true    |
    And "raider" has the following characters
      | name  | guild   |
      | Wonko | Exiled  |
    And I am signed in as "raider"
    And I am at the home page

    When I follow "Guild"
    And I follow "Stabby"

    Then I should see "Stabby" within ".characters"
    And I should not see "Manage Signups"
    And I should not see "Schedule Raid"

  Scenario: User can see their own permission set
    Given "raid_leader" has the following characters
      | name    | guild       | is_main |
      | Weemuu  | Exiled      | true    |
    And I am signed in as "raid_leader"
    And I am at the home page

    When I follow "Guild"
    And I follow "Weemuu"

    Then I should see "Weemuu" within ".characters"
    And I should see "Manage Signups"
    And I should see "Schedule Raid"

  Scenario: Guild leader can change permissions of a guild member
    Given "raid_leader" has the following characters
      | name    | guild       | is_main |
      | Panduu  | Exiled      | true    |
    Given "guild_leader" has the following characters
      | name    | guild       | is_main |
      | Weemuu  | Exiled      | true    |
    And I am signed in as "guild_leader"

    And I am at the home page

    When I follow "Guild"
    And I follow "Panduu"

    Then I should see "Panduu" within ".characters"
    And the "Manage Signups" checkbox should be checked
    And the "Schedule Raid" checkbox should be checked

    When I uncheck "Manage Signups"
    And I uncheck "Schedule Raid"

    And I press "Update Permissions"

    Then I should see "Panduu" within ".characters"
    And the "Manage Signups" checkbox should not be checked
    And the "Schedule Raid" checkbox should not be checked

  Scenario: Guild leader cannot change their own permissions

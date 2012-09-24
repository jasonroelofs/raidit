Feature: Viewing guild member details

  Scenario: Raider can look at details of a user in the same guild
    Given "raid_leader" has the following characters
      | name    | guild       | is_main |
      | Stabby  | Exiled      | false   |
      | Weemuu  | Exiled      | true    |
      | Weemoo  | Mind Crush  | true    |
    And "raider" has the following characters
      | name  | guild   |
      | Wonko | Exiled  |
    And I am signed in as "raider"
    And I am at the home page

    When I follow "Guild"
    And I follow "Weemuu"

    Then I should see "Weemuu" within ".main"
    And I should see "Stabby" within ".alts"
    And I should not see "Weemoo"

  Scenario: Viewing an Alt shows the main
    Given "raid_leader" has the following characters
      | name    | guild       | is_main |
      | Stabby  | Exiled      | false   |
      | Weemuu  | Exiled      | true    |
    And "raider" has the following characters
      | name  | guild   |
      | Wonko | Exiled  |
    And I am signed in as "raider"
    And I am at the home page

    When I follow "Guild"
    And I follow "Stabby"

    Then I should see "Weemuu" within ".main"
    And I should see "Stabby" within ".alts"

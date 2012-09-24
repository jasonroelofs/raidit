Feature: Viewing guild members

  Scenario: User can see all characters of guilds he's a member of
    Given "raider" has the following characters
      | name    | guild       | is_main |
      | Weemuu  | Exiled      | true    |
      | Stabby  | Exiled      | false   |
      | Weemoo  | Mind Crush  | true    |
    And "raid_leader" has the following characters
      | name  | guild   | is_main |
      | Wonko | Exiled  | true    |
    And I am signed in as "raider"
    And I am at the home page

    When I follow "Guild"
    Then the current guild should be "Exiled"
    And I should see "Weemuu"
    And I should see "Stabby"
    And I should see "Wonko"
    And I should not see "Weemoo"

    When I change the guild to "Mind Crush"
    Then I should see "Weemoo"
    And I should not see "Weemuu"
    And I should not see "Wonko"


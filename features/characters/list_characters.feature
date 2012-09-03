Feature: Listing a user's characters

  Scenario: User sees characters by guild
    Given I am signed in as "raid_leader"
    And I am at the home page
    And "raid_leader" has the following characters
      | name    | guild   |
      | Weemuu  | Exiled  |
      | Weemoo   | Mind Crush |

    When I follow "Characters"
    Then I should see "Weemuu" within ".guilded.exiled"
    And I should see "Weemoo" within ".guilded.mindcrush"

  Scenario: User sees his unguilded characters
    Given I am signed in as "raid_leader"
    And I am at the home page
    And "raid_leader" has the following characters
      | name    | character_class |
      | Weemuu  | Mage            |

    When I follow "Characters"
    Then I should see "Unguilded"
    And I should see "Weemuu" within ".unguilded"

  Scenario: User can specify a main character in a guild
    Given I am signed in as "raid_leader"
    And I am at the home page
    And "raid_leader" has the following characters
      | name    | character_class | guild |
      | Weemuu  | Mage            | Exiled |
      | Weemoo  | Shaman          | Exiled |
      | Johnson | Warrior         | Exiled |
    And I follow "Characters"

    When I press "Make Main" for the character "Weemoo"
    Then I should see "Weemoo" within ".exiled .main-character"
    And I should not see the "Make Main" button within ".exiled .main-character"

    When I press "Make Main" for the character "Weemuu"
    Then I should see "Weemuu" within ".exiled .main-character"
    And I should not see "Weemoo" within ".exiled .main-character"

  Scenario: User has one main character per guild he's in
    Given I am signed in as "raid_leader"
    And I am at the home page
    And "raid_leader" has the following characters
      | name    | character_class | guild |
      | Weemuu  | Mage            | Exiled |
      | Weemoo  | Shaman          | Exiled |
      | Johnson | Warrior         | Mind Crush |
      | Stabby  | Rogue           | Mind Crush |
    And I follow "Characters"

    When I press "Make Main" for the character "Weemoo"
    And I press "Make Main" for the character "Stabby"

    Then I should see "Weemoo" within ".exiled .main-character"
    And I should not see the "Make Main" button within ".exiled .main-character"

    And I should see "Stabby" within ".mindcrush .main-character"
    And I should not see the "Make Main" button within ".mindcrush .main-character"

  Scenario: User cannot "main" an unguilded character
    Given I am signed in as "raid_leader"
    And I am at the home page
    And "raid_leader" has the following characters
      | name    | character_class |
      | Weemuu  | Mage            |
      | Weemoo  | Shaman          |
      | Johnson | Warrior         |
    When I follow "Characters"
    Then I should not see the "Make Main" button

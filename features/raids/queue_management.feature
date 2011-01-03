@users @characters
Feature: Admins and Raid Leaders can accept or unaccept raiders for given roles

Scenario: Users cannot change their queue status
  Given I am logged in as "user@raidit.org"
  And a raid exists for tomorrow named "The Raid"
  And I am queued to "The Raid" with "Priest"

  When I follow "Calendar"
  And I follow "The Raid"

  Then I should not see accept buttons

Scenario: Raid leaders can approve and unapprove signups
  Given I am logged in as "leader@raidit.org"
  And a raid exists for tomorrow named "The Raid"

  And I am queued to "The Raid" with "Warrior"
  And "user@raidit.org" is queued to "The Raid" with "Priest"
  And "jason@raidit.org" is queued to "The Raid" with "Mage"

  When I follow "Calendar"
  And I follow "The Raid"

  When I follow "Accept" within "#dps"
  And I follow "Accept" within "#tank"

  Then the raid to "The Raid" should have the following logs
    | who | event | when |
    | Warrior | accepted Warrior as tank | today |
    | Warrior | accepted Mage as dps | today |

  And I refresh

  Then I should see "Mage" is accepted
  And I should see "Warrior" is accepted
  And I should see "Priest" is queued

  When I follow "Queue" within "#dps"
  And I refresh

  Then the raid to "The Raid" should have the following logs
    | who | event | when |
    | Warrior | re-queued Mage as dps | today |

  Then I should see "Mage" is queued
  And I should see "Warrior" is accepted
  And I should see "Priest" is queued

Scenario: Admins can approve and unapprove signups
  Given I am logged in as "jason@raidit.org"
  And a raid exists for tomorrow named "The Raid"

  And I am queued to "The Raid" with "Mage"
  And "user@raidit.org" is queued to "The Raid" with "Priest"
  And "leader@raidit.org" is queued to "The Raid" with "Warrior"

  When I follow "Calendar"
  And I follow "The Raid"

  When I follow "Accept" within "#dps"
  And I follow "Accept" within "#tank"

  Then the raid to "The Raid" should have the following logs
    | who | event | when |
    | Mage | accepted Warrior as tank | today |
    | Mage | accepted Mage as dps | today |

  And I refresh

  Then I should see "Mage" is accepted
  And I should see "Warrior" is accepted
  And I should see "Priest" is queued

  When I follow "Queue" within "#dps"
  And I refresh

  Then I should see "Mage" is queued
  And I should see "Warrior" is accepted
  And I should see "Priest" is queued

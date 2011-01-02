@users
Feature: Calendar view

Scenario: Shows four weeks of data
  Given I am logged in as "jason@raidit.org"
  And today is "2010/11/11"
  And I follow "Calendar"
  Then I should see "Dec 01"

Scenario: View rolls over on Sunday
  Given I am logged in as "jason@raidit.org"
  And today is "2010/08/02"
  And I follow "Calendar"
  Then I should not see "Sep"
  And I should see "Aug 01"

  When today is "2010/08/08"
  And I refresh
  Then I should see "Sep 01"


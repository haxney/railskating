@view @competition
Feature: Competition pages display their events
  In order to view a competition
  The competition page
  Should list all of its events

  Scenario: An empty competition
    Given a competition
    When I visit the competition page
    Then there should be no events

  Scenario: A competition with events
    Given a competition with the following events:
      | number | level    | dances                                         |
      |      1 | Newcomer | American Cha Cha                               |
      |      2 | Newcomer | American Rumba                                 |
      |      3 | Newcomer | American Swing                                 |
      |      4 | Bronze   | American Cha Cha/American Rumba                |
      |      5 | Bronze   | American Swing                                 |
      |      6 | Silver   | American Cha Cha/American Rumba                |
      |      7 | Silver   | American Swing                                 |
      |      8 | Gold     | American Cha Cha/American Rumba/American Swing |

    When I visit the competition page
    Then I should see links to the events

@single @final @view @event
Feature:
  In order to display an individual event
  The events page
  Should display fractional results

  Scenario: Couples receive a fractional placement
    Given the following marks in a final round, dance "American Waltz":
      | couple | A | C | D | E | H | I | J |
      |    102 | 2 | 5 | 1 | 4 | 6 | 4 | 3 |
      |    103 | 5 | 4 | 4 | 5 | 4 | 6 | 7 |
      |    106 | 7 | 7 | 7 | 6 | 7 | 7 | 4 |
      |    169 | 3 | 3 | 2 | 7 | 2 | 1 | 1 |
      |    179 | 6 | 6 | 5 | 2 | 5 | 5 | 6 |
      |    212 | 1 | 1 | 3 | 1 | 1 | 2 | 2 |
      |    225 | 4 | 2 | 6 | 3 | 3 | 3 | 5 |

    And the following marks in a final round, dance "American Tango":
      | couple | A | C | D | E | H | I | J |
      |    102 | 3 | 4 | 1 | 4 | 6 | 5 | 3 |
      |    103 | 7 | 5 | 5 | 5 | 5 | 4 | 7 |
      |    106 | 6 | 7 | 7 | 6 | 7 | 7 | 4 |
      |    169 | 2 | 1 | 2 | 7 | 2 | 1 | 1 |
      |    179 | 5 | 6 | 4 | 2 | 4 | 3 | 6 |
      |    212 | 1 | 2 | 3 | 1 | 1 | 2 | 2 |
      |    225 | 4 | 3 | 6 | 3 | 3 | 6 | 5 |

    And the following marks in a final round, dance "American Foxtrot":
      | couple | A | C | D | E | H | I | J |
      |    102 | 3 | 6 | 1 | 4 | 6 | 5 | 2 |
      |    103 | 7 | 7 | 5 | 7 | 4 | 4 | 7 |
      |    106 | 6 | 5 | 7 | 5 | 7 | 7 | 4 |
      |    169 | 2 | 1 | 2 | 6 | 2 | 1 | 1 |
      |    179 | 5 | 4 | 4 | 3 | 5 | 3 | 6 |
      |    212 | 1 | 2 | 3 | 1 | 1 | 2 | 3 |
      |    225 | 4 | 3 | 6 | 2 | 3 | 6 | 5 |

    And the following marks in a final round, dance "American Viennese Waltz":
      | couple | A | C | D | E | H | I | J |
      |    102 | 2 | 7 | 2 | 4 | 6 | 6 | 2 |
      |    103 | 6 | 6 | 5 | 5 | 5 | 4 | 6 |
      |    106 | 7 | 5 | 7 | 6 | 4 | 7 | 4 |
      |    169 | 3 | 1 | 1 | 7 | 1 | 2 | 1 |
      |    179 | 4 | 4 | 4 | 2 | 7 | 3 | 5 |
      |    212 | 1 | 3 | 3 | 3 | 2 | 1 | 3 |
      |    225 | 5 | 2 | 6 | 1 | 3 | 5 | 7 |

    And the following couple names:
      | number | lead name          | lead team         | follow name     | follow team              | no name |
      |    102 | Matthew Sorrentino | MIT               | Theresa Vallese | MIT                      |         |
      |    103 | Adam Peacock       | Unaffiliated      | Andrea Raynor   | Unaffiliated             |         |
      |    106 | Fahmil Shah        | Boston University | Kristie Charoen | Boston University        |         |
      |    169 | George Cometa      | UConn             | Bella Pindrus   | Boston Dance Options     |         |
      |    179 |                    |                   |                 |                          | true    |
      |    212 | Jason Seabury      | UConn             | Nonie Shiverick | Manhattan Ballroom Dance |         |
      |    225 | Jeff McCollum      | MIT               | Lihua Bai       | MIT                      |         |

    When I visit the event page
    Then I should see the following placements for the couples in dance "American Tango":
      | couple | rank |
      |    102 |    3 |
      |    103 |    6 |
      |    106 |    7 |
      |    169 |    2 |
      |    179 |  4.5 |
      |    212 |    1 |
      |    225 |  4.5 |

    And I should see the following in the final summary:
      | number | overall | total | Waltz | Tango | Foxtrot | Viennese Waltz | rule |
      |    102 |       3 |    14 |     4 |     3 |       3 |              4 |      |
      |    103 |       6 |    24 |     5 |     6 |       7 |              6 |      |
      |    106 |       7 |    27 |     7 |     7 |       6 |              7 |      |
      |    169 |       1 |     6 |     2 |     2 |       1 |              1 | R11  |
      |    179 |       5 |  18.5 |     6 |   4.5 |       5 |              3 |      |
      |    212 |       2 |     6 |     1 |     1 |       2 |              2 | R11  |
      |    225 |       4 |  16.5 |     3 |   4.5 |       4 |              5 |      |

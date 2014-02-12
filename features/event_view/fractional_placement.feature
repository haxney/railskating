@single @final @view @event
Feature:
  In order to display an individual event
  The events page
  Should display fractional results

  Scenario: Couples receive a fractional placement
    Given the following marks in a final round, dance "International Waltz":
      | couple | A | B | C | D | E |
      |     81 | 1 | 4 | 1 | 1 | 1 |
      |     82 | 4 | 2 | 2 | 4 | 2 |
      |     83 | 3 | 1 | 4 | 3 | 3 |
      |     84 | 2 | 3 | 3 | 2 | 4 |
      |     85 | 5 | 5 | 5 | 5 | 5 |

    And the following couple names:
      | number | lead name         | lead team             | follow name        | follow team           |
      |     81 | Jolyon Bloomfield | MIT                   | Nancy Li           | MIT                   |
      |     82 | Daniel Pham       | Yale                  | Miranda Kephart    | Yale                  |
      |     83 | Ethan R White     | University of Vermont | Chelsea L Davidson | University of Vermont |
      |     84 | Derek Mullen      | Unaffiliated          | Katrina Gocan      | Unaffiliated          |
      |     85 | Thomas Solley     | RPI                   | Megan Lamare       | RPI                   |

    When I visit the event page
    Then I should see the following placements for the couples in dance "International Waltz":
      | couple | rank |
      |     81 |    1 |
      |     82 |    2 |
      |     83 |  3.5 |
      |     84 |  3.5 |
      |     85 |    5 |

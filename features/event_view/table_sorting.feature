@view @event @single @javascript @sorting
Feature: Sorting a results table
  In order to sort a results table
  The events page
  Should order couples when a header is clicked

  Scenario:
    Given the following marks in a preliminary round #1, dance "International Waltz":
      | couple | A | B | C | D | E | F | G |
      |     10 |   | X | X | X |   |   |   |
      |     11 | X |   | X | X | X | X |   |
      |     12 | X | X |   | X |   |   | X |
      |     13 |   |   | X |   |   | X | X |
      |     14 | X | X |   |   | X | X |   |
      |     15 |   | X | X | X | X | X | X |
      |     16 |   |   |   |   |   | X |   |
      |     17 | X | X | X | X | X |   | X |
      |     18 | X | X | X | X | X | X | X |
      |     19 | X |   |   |   | X |   | X |

    And the following couple names:
      | number | lead name           | lead team             | follow name        | follow team           |
      |     10 | Ross Finman         | MIT                   | Ji Shiyan          | MIT                   |
      |     11 | Jolyon Bloomfield   | MIT                   | Nancy Li           | MIT                   |
      |     12 | Daniel Pham         | Yale                  | Miranda Kephart    | Yale                  |
      |     13 | Ethan R White       | University of Vermont | Chelsea L Davidson | University of Vermont |
      |     14 | Derek Mullen        | Unaffiliated          | Katrina Gocan      | Unaffiliated          |
      |     15 | Thomas Solley       | RPI                   | Megan Lamare       | RPI                   |
      |     16 | Basil Siddiqui      | Harvard University    | Connie Liu         | MIT                   |
      |     17 | Drago Guggiana-Nilo | Harvard University    | Shantel Mays       | Harvard University    |
      |     18 | Roel Mercado        | Columbia University   | Christina LaGamma  | Columbia University   |
      |     19 | Doron Shiffer-Sebba | Brown University      | Huyen Phan         | Brown University      |

    And 6 couples are requested from the preliminary round
    When I visit the event page

    # The initial sort order should be by couple number
    Then the table for round #1 should be sorted by "Number"
    When I click on the "Number" header for round #1
    Then the table for round #1 should be sorted by "Number" descending

    When I click on the "Leader" header for round #1
    Then the table for round #1 should be sorted by "Leader"
    When I click on the "Leader" header for round #1
    Then the table for round #1 should be sorted by "Leader" descending

    When I click on the "Follower" header for round #1
    Then the table for round #1 should be sorted by "Follower"
    When I click on the "Follower" header for round #1
    Then the table for round #1 should be sorted by "Follower" descending

    When I click on the "Judge 'A', International Waltz" header for round #1
    Then the table for round #1 should be sorted by "Judge 'A', International Waltz"
    When I click on the "Judge 'A', International Waltz" header for round #1
    Then the table for round #1 should be sorted by "Judge 'A', International Waltz" descending

    When I click on the "Recalled" header for round #1
    Then the table for round #1 should be sorted by "Recalled"
    When I click on the "Recalled" header for round #1
    Then the table for round #1 should be sorted by "Recalled" descending

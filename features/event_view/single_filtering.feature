@view @event @javascript @single
Feature: Filtering results table
  In order to filter results tables
  The events page
  Should filter out couples when the input changes

  Background:
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

    Given the following marks in a final round #2, dance "International Waltz":
      | couple | A | B | C | D | E |
      |     11 | 1 | 1 | 1 | 2 | 1 |
      |     12 | 4 | 2 | 2 | 1 | 2 |
      |     14 | 3 | 3 | 3 | 5 | 4 |
      |     15 | 2 | 4 | 5 | 4 | 3 |
      |     17 | 5 | 6 | 4 | 3 | 5 |
      |     18 | 6 | 5 | 6 | 6 | 6 |

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

  Scenario: All couples are displayed initially
    When I visit the event page
    Then I should see a preliminary round #1 with the following couples:
      | couple |
      |     10 |
      |     11 |
      |     12 |
      |     13 |
      |     14 |
      |     15 |
      |     16 |
      |     17 |
      |     18 |
      |     19 |

    And I should see a final round #2, dance "International Waltz" with the following couples:
      | couple |
      |     11 |
      |     12 |
      |     14 |
      |     15 |
      |     17 |
      |     18 |

  Scenario: Entering text filters the couples
    When I visit the event page
    And I enter "university" into the event filter box
    Then I should see a preliminary round #1 with the following couples:
      | couple |
      |     13 |
      |     16 |
      |     17 |
      |     18 |
      |     19 |

    And I should see a final round #2, dance "International Waltz" with the following couples:
      | couple |
      |     17 |
      |     18 |

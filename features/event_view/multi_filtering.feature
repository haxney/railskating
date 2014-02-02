@view @event @javascript @multi
Feature: Filtering results table
  In order to filter results tables
  The events page
  Should filter out couples when the input changes

  Background:
    Given the following marks in a preliminary round #1, dance "International Tango":
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

    Given the following marks in a preliminary round #1, dance "International Foxtrot":
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

    Given the following marks in a final round #2, dance "International Tango":
      | couple | A | B | E | F | G | I | J |
      |     11 | 2 | 3 | 6 | 5 | 1 | 6 | 1 |
      |     12 | 6 | 2 | 3 | 3 | 3 | 3 | 3 |
      |     14 | 4 | 6 | 2 | 1 | 4 | 1 | 4 |
      |     15 | 3 | 1 | 4 | 4 | 2 | 2 | 5 |
      |     17 | 5 | 5 | 5 | 6 | 6 | 4 | 6 |
      |     18 | 1 | 4 | 1 | 2 | 5 | 5 | 2 |

    Given the following marks in a final round #2, dance "International Foxtrot":
      | couple | A | B | E | F | G | I | J |
      |     11 | 1 | 3 | 6 | 5 | 3 | 5 | 1 |
      |     12 | 2 | 1 | 1 | 3 | 1 | 2 | 3 |
      |     14 | 4 | 5 | 3 | 1 | 6 | 1 | 4 |
      |     15 | 5 | 2 | 4 | 4 | 2 | 3 | 5 |
      |     17 | 6 | 6 | 5 | 6 | 5 | 6 | 6 |
      |     18 | 3 | 4 | 2 | 2 | 4 | 4 | 2 |

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
    Then I should see a preliminary round #1, dance "International Tango" with the following couples:
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

    And I should see a preliminary round #1, dance "International Foxtrot" with the following couples:
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

    And I should see a final round #2, dance "International Tango" with the following couples:
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

    And I should see a final round #2, dance "International Tango" with the following couples:
      | couple |
      |     17 |
      |     18 |

    And I should see a final round #2, dance "International Foxtrot" with the following couples:
      | couple |
      |     17 |
      |     18 |

    And I should see a final summary with the following couples:
      | couple |
      |     17 |
      |     18 |

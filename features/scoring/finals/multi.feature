@multi @final
Feature: Couples in a multi-dance final
  In order to score a final round
  The couples
  Should be placed according to the adjudicators' marks
  To determine the final ranking

  Scenario: Couples are placed by rule 9
    Given the couples received the following places in the final summary:
      | couple | W | T | V | Q | F |
      |     91 | 1 | 1 | 1 | 1 | 1 |
      |     92 | 4 | 2 | 2 | 2 | 2 |
      |     93 | 2 | 3 | 3 | 3 | 3 |
      |     94 | 5 | 5 | 6 | 4 | 5 |
      |     95 | 3 | 4 | 5 | 7 | 7 |
      |     96 | 6 | 7 | 4 | 5 | 6 |
      |     97 | 7 | 6 | 7 | 6 | 4 |
      |     98 | 8 | 8 | 8 | 8 | 8 |

    Then the placement of the couples should be
      | couple | rank |
      |     91 |    1 |
      |     92 |    2 |
      |     93 |    3 |
      |     94 |    4 |
      |     95 |    5 |
      |     96 |    6 |
      |     97 |    7 |
      |     98 |    8 |

  Scenario: Couples are placed by rule 10 (part 1)
    Given the couples received the following places in the final summary:
      | couple | W | T | F |
      |    101 | 1 | 1 | 3 |
      |    102 | 2 | 2 | 1 |
      |    103 | 6 | 4 | 2 |
      |    104 | 5 | 3 | 4 |
      |    105 | 4 | 5 | 5 |
      |    106 | 3 | 6 | 6 |

    Then the placement of the couples should be
      | couple | rank  |
      |    101 | 1 R10 |
      |    102 | 2 R10 |
      |    103 | 3 R10 |
      |    104 | 4 R10 |
      |    105 | 5     |
      |    106 | 6     |

  Scenario: Couples are placed by rule 10 (part 2)
    Given the couples received the following places in the final summary:
      | couple | W | T | F | Q |
      |    101 | 1 | 6 | 4 | 1 |
      |    102 | 6 | 2 | 2 | 2 |
      |    103 | 2 | 1 | 6 | 3 |
      |    104 | 3 | 4 | 1 | 4 |
      |    105 | 5 | 3 | 5 | 5 |
      |    106 | 4 | 5 | 3 | 6 |

    Then the placement of the couples should be
      | couple | rank  |
      |    101 | 1 R10 |
      |    102 | 2 R10 |
      |    103 | 3 R10 |
      |    104 | 4 R10 |
      |    105 | 5 R10 |
      |    106 | 6 R10 |

  Scenario: Couples are placed by rule 11 (first example)
    Given the adjudicators marked the following couples in the final sub-round "W"
      | couple | A | B | C | D | E | F | G |
      |    111 | 1 | 1 | 1 | 1 | 1 | 1 | 1 |
      |    112 | 5 | 3 | 5 | 4 | 3 | 3 | 3 |
      |    113 | 4 | 5 | 4 | 5 | 5 | 5 | 4 |
      |    114 | 3 | 4 | 3 | 3 | 4 | 4 | 5 |
      |    115 | 2 | 2 | 2 | 2 | 2 | 2 | 2 |

    And the adjudicators marked the following couples in the final sub-round "Q"
      | couple | A | B | C | D | E | F | G |
      |    111 | 1 | 1 | 1 | 1 | 2 | 1 | 1 |
      |    112 | 5 | 3 | 3 | 4 | 3 | 4 | 4 |
      |    113 | 4 | 5 | 5 | 5 | 5 | 5 | 5 |
      |    114 | 3 | 4 | 4 | 3 | 4 | 3 | 3 |
      |    115 | 2 | 2 | 2 | 2 | 1 | 2 | 2 |

    Then the placement of the couples should be
      | couple |  rank |
      |    111 |     1 |
      |    112 | 4 R11 |
      |    113 |     5 |
      |    114 | 3 R11 |
      |    115 |     2 |

  Scenario: Couples are placed by rule 11 (second example)
    Given the adjudicators marked the following couples in the final sub-round "F"
      | couple | A | B | C | D | E |
      |    111 | 2 | 5 | 6 | 6 | 4 |
      |    112 | 6 | 8 | 1 | 5 | 7 |
      |    113 | 8 | 3 | 2 | 8 | 8 |
      |    114 | 7 | 4 | 3 | 3 | 2 |
      |    115 | 1 | 1 | 5 | 2 | 6 |
      |    116 | 4 | 2 | 4 | 1 | 1 |
      |    117 | 5 | 7 | 8 | 7 | 3 |
      |    118 | 3 | 6 | 7 | 4 | 5 |

    Given the adjudicators marked the following couples in the final sub-round "T"
      | couple | A | B | C | D | E |
      |    111 | 3 | 6 | 5 | 5 | 4 |
      |    112 | 7 | 8 | 3 | 8 | 7 |
      |    113 | 8 | 5 | 4 | 6 | 8 |
      |    114 | 6 | 3 | 1 | 3 | 3 |
      |    115 | 1 | 1 | 2 | 4 | 5 |
      |    116 | 5 | 2 | 6 | 2 | 2 |
      |    117 | 2 | 7 | 7 | 7 | 1 |
      |    118 | 4 | 4 | 8 | 1 | 6 |

    Then the placement of the couples should be
      | couple | rank  |
      |    111 | 4 R11 |
      |    112 | 6 R11 |
      |    113 | 7 R11 |
      |    114 | 3     |
      |    115 | 1 R11 |
      |    116 | 2 R11 |
      |    117 | 8 R10 |
      |    118 | 5 R11 |

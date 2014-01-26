@scoring @multi @final
Feature: Couples in a multi-dance final
  In order to score a final round
  The couples
  Should be placed according to the adjudicators' marks
  To determine the final ranking

  @rule9
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

    Then the placement of the couples should be:
      | couple | rank |
      |     91 |    1 |
      |     92 |    2 |
      |     93 |    3 |
      |     94 |    4 |
      |     95 |    5 |
      |     96 |    6 |
      |     97 |    7 |
      |     98 |    8 |

  @rule10
  Scenario: Couples are placed by rule 10 (part 1)
    Given the couples received the following places in the final summary:
      | couple | W | T | F |
      |    101 | 1 | 1 | 3 |
      |    102 | 2 | 2 | 1 |
      |    103 | 6 | 4 | 2 |
      |    104 | 5 | 3 | 4 |
      |    105 | 4 | 5 | 5 |
      |    106 | 3 | 6 | 6 |

    Then the placement of the couples should be:
      | couple | rank | rule |
      |    101 |    1 | R10  |
      |    102 |    2 | R10  |
      |    103 |    3 | R10  |
      |    104 |    4 | R10  |
      |    105 |    5 |      |
      |    106 |    6 |      |

  @rule10
  Scenario: Couples are placed by rule 10 (part 2)
    Given the couples received the following places in the final summary:
      | couple | W | T | F | Q |
      |    101 | 1 | 6 | 4 | 1 |
      |    102 | 6 | 2 | 2 | 2 |
      |    103 | 2 | 1 | 6 | 3 |
      |    104 | 3 | 4 | 1 | 4 |
      |    105 | 5 | 3 | 5 | 5 |
      |    106 | 4 | 5 | 3 | 6 |

    Then the placement of the couples should be:
      | couple | rank | rule |
      |    101 |    1 | R10  |
      |    102 |    2 | R10  |
      |    103 |    3 | R10  |
      |    104 |    4 | R10  |
      |    105 |    5 | R10  |
      |    106 |    6 | R10  |

  @rule11
  Scenario: Couples are placed by rule 11 (first example)
    Given the following marks in a final round, dance "International Waltz":
      | couple | A | B | C | D | E | F | G |
      |    111 | 1 | 1 | 1 | 1 | 1 | 1 | 1 |
      |    112 | 5 | 3 | 5 | 4 | 3 | 3 | 3 |
      |    113 | 4 | 5 | 4 | 5 | 5 | 5 | 4 |
      |    114 | 3 | 4 | 3 | 3 | 4 | 4 | 5 |
      |    115 | 2 | 2 | 2 | 2 | 2 | 2 | 2 |

    Given the following marks in a final round, dance "International Quickstep":
      | couple | A | B | C | D | E | F | G |
      |    111 | 1 | 1 | 1 | 1 | 2 | 1 | 1 |
      |    112 | 5 | 3 | 3 | 4 | 3 | 4 | 4 |
      |    113 | 4 | 5 | 5 | 5 | 5 | 5 | 5 |
      |    114 | 3 | 4 | 4 | 3 | 4 | 3 | 3 |
      |    115 | 2 | 2 | 2 | 2 | 1 | 2 | 2 |

    Then the placement of the couples should be:
      | couple | rank | rule |
      |    111 |    1 |      |
      |    112 |    4 | R11  |
      |    113 |    5 |      |
      |    114 |    3 | R11  |
      |    115 |    2 |      |

  @rule11
  Scenario: Couples are placed by rule 11 (second example)
    Given the following marks in a final round, dance "International Foxtrot":
      | couple | A | B | C | D | E |
      |    111 | 2 | 5 | 6 | 6 | 4 |
      |    112 | 6 | 8 | 1 | 5 | 7 |
      |    113 | 8 | 3 | 2 | 8 | 8 |
      |    114 | 7 | 4 | 3 | 3 | 2 |
      |    115 | 1 | 1 | 5 | 2 | 6 |
      |    116 | 4 | 2 | 4 | 1 | 1 |
      |    117 | 5 | 7 | 8 | 7 | 3 |
      |    118 | 3 | 6 | 7 | 4 | 5 |

    Given the following marks in a final round, dance "International Tango":
      | couple | A | B | C | D | E |
      |    111 | 3 | 6 | 5 | 5 | 4 |
      |    112 | 7 | 8 | 3 | 8 | 7 |
      |    113 | 8 | 5 | 4 | 6 | 8 |
      |    114 | 6 | 3 | 1 | 3 | 3 |
      |    115 | 1 | 1 | 2 | 4 | 5 |
      |    116 | 5 | 2 | 6 | 2 | 2 |
      |    117 | 2 | 7 | 7 | 7 | 1 |
      |    118 | 4 | 4 | 8 | 1 | 6 |

    Then the placement of the couples should be:
      | couple | rank | rule |
      |    111 |    4 | R11  |
      |    112 |    6 | R11  |
      |    113 |    7 | R11  |
      |    114 |    3 |      |
      |    115 |    1 | R11  |
      |    116 |    2 | R11  |
      |    117 |    8 | R10  |
      |    118 |    5 | R11  |

  @rule11
  Scenario: Results from Brown 2013 Silver American Cha/Rumba
    Given the following marks in a final round, dance "International Cha Cha":
      | couple | A | B | E | F | G | I | J |
      |    158 | 4 | 7 | 5 | 5 | 7 | 3 | 4 |
      |    160 | 1 | 2 | 4 | 2 | 1 | 1 | 1 |
      |    276 | 3 | 6 | 1 | 1 | 5 | 5 | 5 |
      |    294 | 7 | 5 | 3 | 7 | 6 | 6 | 6 |
      |    307 | 5 | 3 | 6 | 3 | 3 | 4 | 3 |
      |    350 | 2 | 1 | 2 | 4 | 2 | 2 | 2 |
      |    365 | 6 | 4 | 7 | 6 | 4 | 7 | 7 |

    Given the following marks in a final round, dance "International Rumba":
      | couple | A | B | E | F | G | I | J |
      |    158 | 3 | 7 | 7 | 5 | 6 | 1 | 5 |
      |    160 | 1 | 2 | 6 | 3 | 2 | 3 | 1 |
      |    276 | 4 | 3 | 1 | 1 | 3 | 5 | 6 |
      |    294 | 6 | 6 | 3 | 2 | 7 | 6 | 4 |
      |    307 | 7 | 5 | 5 | 4 | 5 | 4 | 3 |
      |    350 | 2 | 1 | 2 | 6 | 1 | 2 | 2 |
      |    365 | 5 | 4 | 4 | 7 | 4 | 7 | 7 |

    Then the placement of the couples should be:
      | couple | rank | rule |
      |    158 |    5 |      |
      |    160 |    2 | R11  |
      |    276 |    3 | R11  |
      |    294 |    6 | R11  |
      |    307 |    4 | R11  |
      |    350 |    1 | R11  |
      |    365 |    7 | R11  |

  @rule11
  Scenario: Results from Brown 2013 Silver International Waltz/Quickstep
    Given the following marks in a final round, dance "International Waltz":
      | couple | A | B | E | F | G | I | J |
      |    112 | 1 | 2 | 1 | 2 | 1 | 3 | 1 |
      |    162 | 5 | 4 | 7 | 6 | 6 | 5 | 6 |
      |    165 | 4 | 1 | 8 | 3 | 5 | 6 | 3 |
      |    213 | 6 | 7 | 4 | 4 | 8 | 7 | 4 |
      |    223 | 3 | 3 | 6 | 5 | 2 | 2 | 5 |
      |    286 | 2 | 5 | 2 | 1 | 3 | 1 | 2 |
      |    345 | 7 | 8 | 3 | 8 | 4 | 8 | 8 |
      |    365 | 8 | 6 | 5 | 7 | 7 | 4 | 7 |

    Given the following marks in a final round, dance "International Quickstep":
      | couple | A | B | E | F | G | I | J |
      |    112 | 1 | 2 | 1 | 1 | 1 | 1 | 1 |
      |    162 | 5 | 6 | 5 | 2 | 6 | 7 | 6 |
      |    165 | 2 | 1 | 3 | 6 | 5 | 5 | 4 |
      |    213 | 4 | 5 | 4 | 5 | 7 | 8 | 3 |
      |    223 | 7 | 3 | 7 | 4 | 3 | 3 | 7 |
      |    286 | 3 | 4 | 2 | 3 | 2 | 2 | 2 |
      |    345 | 6 | 8 | 6 | 8 | 4 | 4 | 5 |
      |    365 | 8 | 7 | 8 | 7 | 8 | 6 | 8 |

    Then the placement of the couples should be:
      | couple | rank | rule |
      |    112 |    1 |      |
      |    162 |    6 | R11  |
      |    165 |    3 | R11  |
      |    213 |    5 | R11  |
      |    223 |    4 | R11  |
      |    286 |    2 |      |
      |    345 |    8 | R11  |
      |    365 |    7 | R11  |

  @rule10
  Scenario: Results from Brown 2013 Silver International Cha-cha/Rumba
    Given the following marks in a final round, dance "International Cha Cha":
      | couple | A | C | D | E | H | I | J |
      |    155 | 6 | 3 | 4 | 4 | 4 | 7 | 7 |
      |    176 | 7 | 7 | 7 | 2 | 3 | 4 | 5 |
      |    213 | 3 | 6 | 3 | 6 | 6 | 6 | 4 |
      |    276 | 5 | 1 | 5 | 3 | 1 | 2 | 2 |
      |    279 | 1 | 4 | 2 | 5 | 5 | 5 | 3 |
      |    305 | 4 | 2 | 6 | 7 | 7 | 1 | 6 |
      |    507 | 2 | 5 | 1 | 1 | 2 | 3 | 1 |

    Given the following marks in a final round, dance "International Rumba":
      | couple | A | C | D | E | H | I | J |
      |    155 | 4 | 4 | 3 | 2 | 3 | 7 | 7 |
      |    176 | 6 | 2 | 6 | 4 | 6 | 5 | 3 |
      |    213 | 5 | 3 | 4 | 5 | 7 | 4 | 4 |
      |    276 | 3 | 6 | 2 | 3 | 1 | 2 | 1 |
      |    279 | 7 | 5 | 5 | 7 | 4 | 6 | 5 |
      |    305 | 2 | 1 | 7 | 6 | 5 | 1 | 6 |
      |    507 | 1 | 7 | 1 | 1 | 2 | 3 | 2 |

    Then the placement of the couples should be:
      | couple | rank | rule |
      |    155 |    3 |      |
      |    176 |    6 |      |
      |    213 |    5 | R10  |
      |    276 |    2 |      |
      |    279 |    4 | R10  |
      |    305 |    7 |      |
      |    507 |    1 |      |

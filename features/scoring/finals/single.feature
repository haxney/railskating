@scoring @final @single
Feature: Couples in a single-dance final
  In order to score a final round
  The couples
  Should be placed according to the adjudicators' marks
  To determine the final ranking

  @rule5
  Scenario: Couples are placed by rule 5
    Given the following marks in a final round:
      | couple | A | B | C | D | E |
      |     51 | 1 | 1 | 1 | 2 | 1 |
      |     52 | 4 | 2 | 2 | 1 | 2 |
      |     53 | 3 | 3 | 3 | 5 | 4 |
      |     54 | 2 | 4 | 5 | 4 | 3 |
      |     55 | 5 | 6 | 4 | 3 | 5 |
      |     56 | 6 | 5 | 6 | 6 | 6 |

    Then the sub-placement of the couples should be:
      | couple | rank |
      |     51 |    1 |
      |     52 |    2 |
      |     53 |    3 |
      |     54 |    4 |
      |     55 |    5 |
      |     56 |    6 |

  @rule6
  Scenario: Couples are placed by rule 6
    Given the following marks in a final round:
      | couple | A | B | C | D | E | F | G |
      |     61 | 1 | 1 | 2 | 1 | 4 | 2 | 1 |
      |     62 | 6 | 2 | 1 | 5 | 2 | 1 | 2 |
      |     63 | 2 | 4 | 3 | 3 | 6 | 3 | 3 |
      |     64 | 3 | 3 | 5 | 2 | 1 | 5 | 4 |
      |     65 | 4 | 5 | 6 | 4 | 3 | 6 | 5 |
      |     66 | 5 | 6 | 4 | 6 | 5 | 4 | 6 |

    Then the sub-placement of the couples should be:
      | couple | rank |
      |     61 |    1 |
      |     62 |    2 |
      |     63 |    3 |
      |     64 |    4 |
      |     65 |    5 |
      |     66 |    6 |

  @rule7
  Scenario: Couples are placed by rule 7
    Given the following marks in a final round:
      | couple | A | B | C | D | E | F | G |
      |     71 | 3 | 1 | 6 | 1 | 1 | 2 | 1 |
      |     72 | 2 | 2 | 1 | 5 | 3 | 1 | 3 |
      |     73 | 1 | 5 | 4 | 2 | 2 | 6 | 2 |
      |     74 | 5 | 4 | 2 | 4 | 6 | 5 | 4 |
      |     75 | 4 | 6 | 3 | 3 | 5 | 4 | 6 |
      |     76 | 6 | 3 | 5 | 6 | 4 | 3 | 5 |

    Then the sub-placement of the couples should be:
      | couple | rank |
      |     71 |    1 |
      |     72 |    2 |
      |     73 |    3 |
      |     74 |    4 |
      |     75 |    5 |
      |     76 |    6 |

  @rule8
  Scenario: Couples are placed by rule 8
    Given the following marks in a final round:
      | couple | A | B | C | D | E | F | G |
      |     81 | 3 | 3 | 3 | 2 | 5 | 2 | 3 |
      |     82 | 4 | 4 | 4 | 3 | 2 | 3 | 2 |
      |     83 | 2 | 2 | 6 | 6 | 4 | 1 | 4 |
      |     84 | 1 | 6 | 1 | 5 | 1 | 4 | 6 |
      |     85 | 5 | 5 | 5 | 1 | 3 | 6 | 1 |
      |     86 | 6 | 1 | 2 | 4 | 6 | 5 | 5 |

    Then the sub-placement of the couples should be:
      | couple | rank |
      |     81 |    1 |
      |     82 |    2 |
      |     83 |    3 |
      |     84 |    4 |
      |     85 |    5 |
      |     86 |    6 |

  @rule7
  Scenario: Couples receive a fractional placement
    Given the following marks in a final round:
      | couple | A | B | C | D | E |
      |     81 | 1 | 4 | 1 | 1 | 1 |
      |     82 | 4 | 2 | 2 | 4 | 2 |
      |     83 | 3 | 1 | 4 | 3 | 3 |
      |     84 | 2 | 3 | 3 | 2 | 4 |
      |     85 | 5 | 5 | 5 | 5 | 5 |

    Then the sub-placement of the couples should be:
      | couple | rank |
      |     81 |    1 |
      |     82 |    2 |
      |     83 |  3.5 |
      |     84 |  3.5 |
      |     85 |    5 |

  Scenario: Couples receive a fractional placement (Brown 2013 event 26)
    Given the following marks in a final round:
      | couple | A | C | D | E | H | I | J |
      |    102 | 3 | 4 | 1 | 4 | 6 | 5 | 3 |
      |    103 | 7 | 5 | 5 | 5 | 5 | 4 | 7 |
      |    106 | 6 | 7 | 7 | 6 | 7 | 7 | 4 |
      |    169 | 2 | 1 | 2 | 7 | 2 | 1 | 1 |
      |    179 | 5 | 6 | 4 | 2 | 4 | 3 | 6 |
      |    212 | 1 | 2 | 3 | 1 | 1 | 2 | 2 |
      |    225 | 4 | 3 | 6 | 3 | 3 | 6 | 5 |

    Then the sub-placement of the couples should be:
      | couple | rank |
      |    102 |    3 |
      |    103 |    6 |
      |    106 |    7 |
      |    169 |    2 |
      |    179 |  4.5 |
      |    212 |    1 |
      |    225 |  4.5 |

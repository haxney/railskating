Feature: Couples in the final placed by simple majority
  In order to score a final round
  The couples
  Should be placed according to the adjudicators marks
  To determine the final ranking

  Scenario: Couples are correctly placed by rule 5
    Given the adjudicators marked the following couples in a final round
      | couple | A | B | C | D | E |
      |     51 | 1 | 1 | 1 | 2 | 1 |
      |     52 | 4 | 2 | 2 | 1 | 2 |
      |     53 | 3 | 3 | 3 | 5 | 4 |
      |     54 | 2 | 4 | 5 | 4 | 3 |
      |     55 | 5 | 6 | 4 | 3 | 5 |
      |     55 | 6 | 5 | 6 | 6 | 6 |

    Then the placement of the couples should be
      | couple | rank |
      |     51 |    1 |
      |     52 |    2 |
      |     53 |    3 |
      |     54 |    4 |
      |     55 |    5 |

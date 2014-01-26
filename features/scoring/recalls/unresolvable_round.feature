@scoring @single @prelim
Feature: Chairman of Adjudicators must decide how to resolve a round
  In order to resolve a round in which the number of requested couples cannot be recalled
  The couples
  Should be recalled according to the chairman's decision
  To advance to the next round of the competition

  Background:
    Given the following marks in a preliminary round:
      | couple | A | B | C | D | E | F | G |
      |     10 |   | X | X | X |   | X |   |
      |     11 | X |   | X | X | X | X | X |
      |     12 | X | X |   | X |   |   | X |
      |     13 |   |   | X |   |   | X | X |
      |     14 | X | X |   |   | X | X |   |
      |     15 |   | X | X | X | X | X | X |
      |     16 |   |   |   |   |   |   |   |
      |     17 | X | X | X | X | X |   | X |
      |     18 | X | X | X | X | X | X | X |
      |     19 | X |   |   |   | X |   |   |

    And 6 couples are requested from the preliminary round

  Scenario: The round is not resolved
    Then the preliminary round should not be resolved

  Scenario: Resolution of the round requires the chairman to set the cutoff
    Then the possible cutoffs of the round should be 6 marks, 4 couples and 4 marks, 7 couples
    Then the following couples should be recalled from the preliminary round with a cutoff of 6 marks:
      | couple |
      |     11 |
      |     15 |
      |     17 |
      |     18 |

    Then the following couples should be recalled from the preliminary round with a cutoff of 4 marks:
      | couple |
      |     10 |
      |     11 |
      |     12 |
      |     14 |
      |     15 |
      |     17 |
      |     18 |

Feature: Couples recalled for a multi-dance round determined by adjudicator's marks
  In order to score an individual round
  The couples
  Should be recalled according to the adjudicators' marks
  To advance to the next round of the competition

  Background:
    Given the adjudicators marked the following couples in the preliminary sub-round "1"
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
    And the adjudicators marked the following couples in the preliminary sub-round "2"
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
    And 6 couples are requested from the preliminary round

  Scenario: Couples each receive the number of marks given by the adjudicators
    Then 6 marks should exist for couple 10
      And 10 marks should exist for couple 11
      And 8 marks should exist for couple 12
      And 6 marks should exist for couple 13
      And 8 marks should exist for couple 14
      And 12 marks should exist for couple 15
      And 2 marks should exist for couple 16
      And 12 marks should exist for couple 17
      And 14 marks should exist for couple 18
      And 6 marks should exist for couple 19

  Scenario: Adjudicators call back exactly as many couples as requested
    Then the preliminary round should be resolved
      And 6 couples should be recalled from the preliminary round
      And the following couples should be recalled from the preliminary round
          | couple |
          |     11 |
          |     12 |
          |     14 |
          |     15 |
          |     17 |
          |     18 |

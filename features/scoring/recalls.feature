Feature: Couples recalled for a round determined by adjudicator's marks
  In order to score an individual round
  The couples
  Should be recalled according to the adjudicators' marks
  To advance to the next round of the competition

  Background:
    Given an event exists
      And a sub event exists with event: the event
      And a round exists with event: the event, requested: 6
      And a sub round exists with round: the round, sub_event: the sub event
      And the adjudicators marked the following couples in the sub round
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
        |     19 | X |   |   |   | X |   |   |

  Scenario: Adjudicators call back exactly as many couples as requested
    Then a mark should exist with couple: couple "11", adjudicator: adjudicator "D"
      And 3 marks should exist with couple: couple "10"
      And 5 marks should exist with couple: couple "11"
      And 4 marks should exist with couple: couple "12"
      And 3 marks should exist with couple: couple "13"
      And 4 marks should exist with couple: couple "14"
      And 6 marks should exist with couple: couple "15"
      And 1 marks should exist with couple: couple "16"
      And 6 marks should exist with couple: couple "17"
      And 7 marks should exist with couple: couple "18"
      And 2 marks should exist with couple: couple "19"

      #Then the 6 couples with the most marks should be recalled

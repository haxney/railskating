Feature: Couples recalled for a round determined by adjudicator's marks
  In order to score an individual round
  The couples
  Should be recalled according to the adjudicators' marks
  To advance to the next round of the competition

  Scenario: Adjudicators call back exactly as many couples as requested
    Given a competition exists
    And an event exists with competition: the competition
    And a sub event exists with event: the event
    And 10 couples exist with event: the event
    And 6 adjudicators exist with competition: the competition
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
    Then the 1st mark should be in couple "10"'s marks
    Then a mark should exist with couple: couple "11", adjudicator: adjudicator "D"

    #Then the 6 couples with the most marks should be recalled

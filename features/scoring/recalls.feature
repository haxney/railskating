Feature: Couples recalled for a round determined by adjudicator's marks
  In order to score an individual round
  The couples
  Should be recalled according to the adjudicators' marks
  To advance to the next round of the competition

  # | No | A | B | C | D | E | F | G | Total |
  # |----+---+---+---+---+---+---+---+-------|
  # | 10 |   | X | X | X |   |   |   |     3 |
  # | 11 | X |   | X | X | X | X |   |     6 |
  # | 12 | X | X |   | X |   |   | X |     4 |
  # | 13 |   |   | X |   |   | X | X |     3 |
  # | 14 | X | X |   |   | X | X |   |     4 |
  # | 15 |   | X | X | X | X | X | X |     6 |
  # | 16 |   |   |   |   |   | X |   |     1 |
  # | 17 | X | X | X | X | X |   | X |     6 |
  # | 18 | X | X | X | X | X | X | X |     7 |
  # | 19 | X |   |   |   | X |   |   |     2 |
  Scenario: Adjudicators call back exactly as many couples as requested
    Given a competition exists
    And an event exists with competition: the competition
    And a sub event exists with event: the event
    And 10 couples exist with event: the event
    And 6 adjudicators exist with competition: the competition
    And a round exists with event: the event, requested: 6
    And a sub round exists with round: the round, sub_event: the sub event
    # Should not have to specify sub_round each time, can this be done?
    And the following marks exist
      | adjudicator     | couple     |
      | 1st adjudicator | 2nd couple |
    Then the 1st mark should be in the 2nd couple's marks

    #Then the 6 couples with the most marks should be recalled

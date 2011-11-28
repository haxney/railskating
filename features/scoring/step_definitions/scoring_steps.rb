# Step definitions for scores

# Turn a table of marks into a set of {Couple}s, {Adjudicator}s, and {Mark}s.
#
# The table is of the form:
#
#     | couple | A | B | C | D | E | F | G |
#     |     10 |   | X | X | X |   |   |   |
#     |     11 | X |   | X | X | X | X |   |
#     |     12 | X | X |   | X |   |   | X |
#     |     13 |   |   | X |   |   | X | X |
#     |     14 | X | X |   |   | X | X |   |
#     |     15 |   | X | X | X | X | X | X |
#     |     16 |   |   |   |   |   | X |   |
#     |     17 | X | X | X | X | X |   | X |
#     |     18 | X | X | X | X | X | X | X |
#     |     19 | X |   |   |   | X |   |   |
#
# Each {Couple} and {Adjudicator} will be created, unless a couple with the
# given number or an adjudicator with the given shorthand exists, respectively.
# This allows for the use of multiple scoring tables for different
Given(/^the adjudicators marked the following couples (?:for|in) #{capture_model}$/) do |sub_round_str, table|
  sub_round = model!(sub_round_str)
  expect_model_class(sub_round, SubRound)
  sub_event = sub_round.sub_event
  event = sub_event.event
  competition = event.competition

  # Remap the headers so that all the columns (aside from the first, the
  # "couple" column) are instances of the `Adjudicator` model (created by a
  # factory).
  table.map_headers! do |header|
    if header == 'couple'
      header
    else
      find_or_create_model("adjudicator",
                           header,
                           competition: competition,
                           shorthand: header)
    end
  end

  # Create the couple and assign them marks for the sub round.
  table.hashes.each do |row|
    label = row.delete('couple')
    couple = find_or_create_model('couple',
                                  label,
                                  event: event,
                                  number: label.to_i)

    # Each adjudicator's mark (or lack thereof) for the current couple
    row.each do |judge, place|
      place = '0' if place == 'X'

      # Only create the mark if the entry in the table is not ' '.
      create_model('mark',
                   adjudicator: judge,
                   couple: couple,
                   sub_round: sub_round,
                   placement: place.to_i) if /\w+/ =~ place
    end
  end
end

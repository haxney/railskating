# Turn a table of marks into a set of `Couple`s, `Adjudicator`s, and `Mark`s.
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
# Each `Couple` and `Adjudicator` will be created, unless a couple with the
# given number or an adjudicator with the given shorthand exists, respectively.
# This allows for the use of multiple scoring tables for different
Given(/^the adjudicators marked the following couples in (?:a|the) (preliminary|final) (?:sub-)?round(?: "(.+)")?:$/) do |prelim, round_name, table|
  @competition ||= FactoryGirl.create(:competition)
  @event ||= FactoryGirl.create(:event, competition: @competition)
  @round ||= FactoryGirl.create(:round, event: @event, final: prelim == 'final')
  @sub_rounds ||= {}
  sub_event = FactoryGirl.create(:sub_event, event: @event)
  sub_round = FactoryGirl.create(:sub_round, round: @round, sub_event: sub_event)
  @sub_rounds[round_name] = sub_round if round_name

  table.map_column!('couple') { |c| c.to_i }

  # Remap the headers so that all the columns (aside from the first, the
  # "couple" column) are instances of the `Adjudicator` model (created by a
  # factory).
  table.map_headers! do |header|
    if header == 'couple'
      header
    else
      find_or_create_adjudicator(header, @competition)
    end
  end

  # Create the couple and assign them marks for the sub round.
  table.hashes.each do |row|
    num = row.delete('couple')
    couple = find_or_create_couple(num, @round)

    # Each adjudicator's mark (or lack thereof) for the current couple
    row.each do |judge, place|
      place = '0' if place == 'X'

      # Only create the mark if the entry in the table is not ' '.
      FactoryGirl.create(:mark,
        adjudicator: judge,
        couple: couple,
        sub_round: sub_round,
        placement: place.to_i) if /\w+/ =~ place
    end
  end
end

# Create `SubPlacement` objects from a table of the form
#
#     | couple | W | T | V | Q | F |
#     |     91 | 1 | 1 | 1 | 1 | 1 |
#     |     92 | 4 | 2 | 2 | 2 | 2 |
#     |     93 | 2 | 3 | 3 | 3 | 3 |
#     |     94 | 5 | 5 | 6 | 4 | 5 |
#     |     95 | 3 | 4 | 5 | 7 | 7 |
#     |     96 | 6 | 7 | 4 | 5 | 6 |
#     |     97 | 7 | 6 | 7 | 6 | 4 |
#     |     98 | 8 | 8 | 8 | 8 | 8 |
#
# For the purpose of creating dances, this will always assume the standard
# section when converting single-letter dance names to `Dance` objects.
Given(/^the couples received the following places in the final summary:$/) do |table|
  @competition = FactoryGirl.create(:competition)
  @event = FactoryGirl.create(:event, competition: @competition)
  @round = FactoryGirl.create(:round, event: @event, final: true)

  table.map_column!('couple') { |c| c.to_i }

  table.map_headers! do |header|
    if header == 'couple'
      header
    else
      find_or_create_sub_event(header, @round)
    end
  end

  table.hashes.each do |row|
    num = row.delete('couple')
    couple = find_or_create_couple(num, @round)

    row.each do |sub_event, place|

      # Only create the mark if the entry in the table is not ' '.
      FactoryGirl.create(:sub_placement,
                         couple: couple,
                         sub_event: sub_event,
                         rank: place.to_i)
    end
  end
end

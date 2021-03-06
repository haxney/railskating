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
Given(/^the following marks in (?:a|the) (preliminary|final) round(?: #(\d+))?(?:, dance "(.+)")?:$/) do |prelim, round_num, dance_name, table|
  @event ||= create(:event)

  # Remap the headers so that all the columns (aside from the first, the
  # "couple" column) are instances of the `Adjudicator` model (created by a
  # factory).
  table.map_headers! do |header|
    if header == 'couple'
      header
    else
      create(:adjudicator, shorthand: header)
    end
  end
  table.hashes # Force the application of `map_headers!`

  round_opts = { event: @event, final: prelim == 'final' }
  round_opts[:number] = round_num if round_num
  @round = create(:round, round_opts)

  @round.adjudicators = table.headers[1..-1]

  @dance = Dance.find_by(name: dance_name || 'American Mambo')
  # Might not actually create a sub event, since it is initialized with a call
  # to `find_or_create_by`
  @sub_event = create(:sub_event, event: @event, dance: @dance)
  @sub_round = create(:sub_round, round: @round, sub_event: @sub_event)

  # Create the couple and assign them marks for the sub round.
  table.hashes.each do |row|
    num = row.delete('couple')
    couple = create(:couple, number: num, event: @event)
    # This is normally a race condition, but tests are single-threaded.
    @round.couples << couple unless @round.couples.include?(couple)

    # Each adjudicator's mark (or lack thereof) for the current couple
    row.each do |judge, place|
      place = '0' if place == 'X'

      # Only create the mark if the entry in the table is not ' '.
      create(:mark,
             adjudicator: judge,
             couple: couple,
             sub_round: @sub_round,
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
  @competition = create(:competition)
  @event = create(:event, competition: @competition)
  @round = create(:round, event: @event, final: true)

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
      create(:sub_placement,
             couple: couple,
             sub_event: sub_event,
             rank: place.to_i)
    end
  end
end

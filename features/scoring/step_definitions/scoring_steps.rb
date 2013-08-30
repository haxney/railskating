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
Given(/^the adjudicators marked the following couples in (?:a|the) preliminary (?:sub-)?round(?: "(.+)")?$/) do |round_name, table|
  @competition ||= FactoryGirl.create(:competition)
  @event ||= FactoryGirl.create(:event, competition: @competition)
  @round ||= FactoryGirl.create(:round, event: @event)
  @sub_rounds ||= {}
  sub_event = FactoryGirl.create(:sub_event, event: @event)
  sub_round = FactoryGirl.create(:sub_round, round: @round)
  @sub_rounds[round_name] = sub_round if round_name

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
    num = row.delete('couple').to_i
    couple = find_or_create_couple(num, @event)

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

Then(/^the preliminary round should be resolved$/) do
  expect(@round).to be_resolved
end

Then(/^(\d+) marks should exist for couple (\d+)/) do |num_marks, couple|
  expect(Mark
      .joins(:couple)
      .where(couples: { number: couple.to_i })
      .length).to eq(num_marks.to_i)
end

Then(/^(\d+) couples should be recalled from the preliminary round$/ ) do |count|
  expect(@round.recalled_couples.length).to eq(count.to_i)
end

# Expect {Couple}s, identified by their number, to be recalled from a {Round}.
#
# The table is of the form:
#
#     | couple |
#     |     10 |
#     |     11 |
#     |     12 |
#     |     13 |
#
Then(/^the following couples should be recalled from the preliminary round$/) do |table|
  couple_numbers = @round.recalled_couples.map &:number
  table.hashes.each do |row|
    expect(couple_numbers).to include row['couple'].to_i
  end
end

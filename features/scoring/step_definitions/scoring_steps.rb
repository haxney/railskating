Then(/^the preliminary round should( not)? be resolved$/) do |neg|
  if neg
    expect(@round).not_to be_resolved
  else
    expect(@round).to be_resolved
  end
end

Then(/^(\d+) marks should exist for couple (\d+)/) do |num_marks, couple|
  expect(Mark
      .joins(:couple)
      .where(couples: { number: couple })
      .length).to eq(num_marks)
end

Then(/^(\d+) couples should be recalled from the preliminary round$/ ) do |count|
  expect(@round.recalled_couples.length).to eq(count)
end

# Set the value of `requested` for the sub-round
And(/^(\d+) couples are requested from the preliminary round$/) do |num|
  @round.update(requested: num)
end

Then(/^the possible cutoffs of the round should be (\d+) marks, (\d+) couples and (\d+) marks, (\d+) couples$/) do |lower_m, lower_c, upper_m, upper_c|
  expect(@round.possible_cutoffs.map &:num_marks).to eq([lower_m, upper_m])
  expect(@round.possible_cutoffs.map &:num_couples).to eq([lower_c, upper_c])
end

# Expect `Couple`s, identified by their number, to be recalled from a `Round`.
#
# The table is of the form:
#
#     | couple |
#     |     10 |
#     |     11 |
#     |     12 |
#     |     13 |
#
# The table must be sorted.
Then(/^the following couples should be recalled from the preliminary round(?: with a cutoff of (\d+) marks)?:$/) do |cutoff, table|
  @round.update(cutoff: cutoff) if cutoff

  couple_numbers = @round.recalled_couples.map(&:number).sort
  table.diff!([['couple']] + couple_numbers.map { |num| [num.to_s] } )
end

# Expect `Couple`s, identified by their number, to be placed in an `Event`.
#
# The table is of the form
#
#     | couple | rank |
#     |     51 |    1 |
#     |     52 |    2 |
#     |     53 |    3 |
#     |     54 |    4 |
#     |     55 |    5 |
#
# Or, if there is a multi-dance final decided by rules 10 or 11, then the form is
#
#     | couple | rank  |
#     |     51 | 1 R10 |
#     |     52 | 2 R10 |
#     |     53 | 3     |
#     |     54 | 4 R11 |
#     |     55 | 5 R11 |
#
# The table must be sorted by the couple number, not the placement.
Then(/^the placement of the couples should be:$/) do |table|
  @event.compute_placements

  table.diff!(placements_to_table(@event.placements))
end

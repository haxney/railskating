# Rename the couples according to `table`. The table should be of the following
# form:
#
#     | number | lead name           | lead team             | follow name        | follow team           |
#     |     10 | Ross Finman         | MIT                   | Ji Shiyan          | MIT                   |
#     |     11 | Jolyon Bloomfield   | MIT                   | Nancy Li           | MIT                   |
#     |     12 | Daniel Pham         | Yale                  | Miranda Kephart    | Yale                  |
#     |     13 | Ethan R White       | University of Vermont | Chelsea L Davidson | University of Vermont |
#     |     14 | Derek Mullen        | Unaffiliated          | Katrina Gocan      | Unaffiliated          |
#
# This step must appear after a step which actually creates the couples.
Given(/^the following couple names:$/) do |table|
  table.map_headers! { |h| h.parameterize.underscore.to_sym }

  table.hashes.each do |row|
    couple = Couple.find_by(number: row[:number], event: @event)

    lead_names = row[:lead_name].split($;, 2)
    couple.lead.update(first_name: lead_names.first,
                       last_name: lead_names.last)
    couple.lead.team = Team.find_or_create_by(name: row[:lead_team])
    couple.lead.save

    follow_names = row[:follow_name].split($;, 2)
    couple.follow.update(first_name: follow_names.first,
                       last_name: follow_names.last)
    couple.follow.team = Team.find_or_create_by(name: row[:follow_team])
    couple.follow.save
  end
end

# Visits the page of the current event.
When(/^I visit the event page$/) do
  visit(event_path(@event))
end

# Checks the current page for the specified couples in the given round. Requires
# the current `Event` be set in the `@event` variable.
Then(/^I should see a (preliminary|final) round number (\d+) with the following couples:$/) do |final, round_num, table|
  table.map_headers! { |h| h.parameterize.underscore.to_sym }
  final = final =~ /final/

  round = Round.find_by(number: round_num, event: @event)
  actual = all("table#results_round_#{round.id} tbody tr.couple_row").map do |row|
    { couple: row.find('td.couple_number').text.to_i }
  end

  table.diff!(actual)
end

When(/^I enter "(.+)" into the event filter box$/) do |str|
  find('#event-filter').native.send_keys(str)
end

When(/^I click on the "(.+)" header for round #(\d+)$/) do |header, round_num|
  class_name = column_name_to_class(header)
  round_id = "#results_round_#{round_num}"

  find("#{round_id} #{class_name}").native.send_key(:click)
end

Then(/^the table for round #(\d) should be sorted by "(.+)"( descending)?$/) do |round_num, header, desc|
  class_name = column_name_to_class(header)
  round_id = "#results_round_#{round_num}"
  expect(all("#{round_id} td.#{class_name}").map(&:text)).to be_monotonically_increasing
end

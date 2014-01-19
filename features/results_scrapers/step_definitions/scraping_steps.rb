require 'results_scrapers/zsconcepts'

# Parse `file` using `ResultsScrapers::<mod>.scrape_event`.
Given(/^I parse the file "(.+)" with "(.+)"$/) do |file, mod|
  scrape_func = ResultsScrapers.const_get(mod.to_sym).method(:scrape_event)
  @event = scrape_func.call(Nokogiri::HTML(open(file)))
end

Then(/^the event should be number ([0-9]+)$/) do |num|
  expect(@event[:number]).to eq(num.to_i)
end

Then(/^there should be ([0-9]+) rounds$/) do |num|
  expect(@event[:rounds].length).to eq(num.to_i)
end

Then(/^the level should be (.+)$/) do |level|
  expect(@event[:level]).to eq(level)
end

Then(/^the section should be (.+)$/) do |section|
  expect(@event[:section]).to eq(section)
end

Then(/^the dances should be:$/) do |table|
  table.diff!(@event[:dances].map { |d| [d] })
end

Then(/^round ([0-9]+) should have the following judges:$/) do |round, table|
  table.diff!(@event[:rounds][round.to_i - 1][:judges].map { |j| [j] })
end

Then(/^round ([0-9]+) should( not)? be final$/) do |round, not_final|
  final = @event[:rounds][round.to_i - 1][:final]
  expect(final).to ((not_final == ' not') ? be_false : be_true)
end

# Matches a given round number against a table with couple names. The table
# should have the following headers:
#
#     | number | lead name | lead team | follow name | follow team | no name |
Then(/^round ([0-9]+) should have the following couples:$/) do |round, table|
  table.map_headers! { |h| h.parameterize.underscore.to_sym }
  table.map_column!('number', &:to_i)
  couples = @event[:rounds][round.to_i - 1][:couples]
  couples = couples.map do |c|
    res = Hash[c.map { |k, v| [k, v || "" ] }]
    res.delete(:dances)
    res.delete(:recall_or_place)
    res[:lead_name] ||= ""
    res[:lead_team] ||= ""
    res[:follow_name] ||= ""
    res[:follow_team] ||= ""
    res[:no_name] = res[:no_name].to_s
    res
  end

  table.diff!(couples)
end

# Expect the marks to match the table for a particular dance in a round. The
# table should have a column `number` and a column for each judge and the cells
# should be an "X" for a mark in a preliminary round or a number for final
# rounds in which the couples are placed. The table should look like
#
#     | number | B | E | F | I | J |
#     |    112 | X | X |   | X | X |
#     |    153 |   |   | X | X |   |
#     |    162 |   | X |   |   | X |
Then(/^round ([0-9]+) should have the following marks in the dance "(.+)":$/) do |round, dance, table|
  table.map_column!('number', &:to_i)
  couples = @event[:rounds][round.to_i - 1][:couples]
  actual = couples.map do |c|
    res = {"number" => c[:number]}
    c[:dances][dance].each do |judge, mark|
      res[judge] = case mark
                   when true then 'X'
                   when false then ''
                   when Integer then mark.to_s
                   else
                     raise ResultsScrapers::ScrapeError, "Unexpected mark type #{mark.inspect}"
                   end
    end
    res
  end

  table.diff!(actual)
end

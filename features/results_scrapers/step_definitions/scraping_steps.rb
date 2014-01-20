require 'results_scrapers/zsconcepts'
require 'results_scrapers/importer'

# Parse `file` using `ResultsScrapers::<mod>.scrape_event`.
Given(/^I parse the file "(.+)" with "(.+)"$/) do |file, mod|
  scrape_func = ResultsScrapers.const_get(mod.to_sym).method(:scrape_event)
  @event = scrape_func.call(Nokogiri::HTML(open(file)))
end

Given(/^I import the file "(.+)" with "(.+)" using ([0-9]+) judges$/) do |file, mod, num_judges|
  step %Q{I parse the file "#{file}" with "#{mod}"}
  comp = FactoryGirl.create(:competition)
  (1..num_judges.to_i).each { |i| FactoryGirl.create(:adjudicator, competition: comp) }
  @imported_event = ResultsScrapers::Importer.import_event(@event, comp)
end

Then(/^the( imported)? event should be number ([0-9]+)$/) do |imported, num|
  src = if imported
          @imported_event.number
        else
          @event[:number]
        end
  expect(src).to eq(num.to_i)
end

Then(/^there should be ([0-9]+) (imported )?rounds$/) do |num, imported|
  src = imported ? @imported_event.rounds : @event[:rounds]
  expect(@event[:rounds].length).to eq(num.to_i)
end

Then(/^the( imported)? level should be (.+)$/) do |imported, level|
  src = imported ? @imported_event.level.name : @event[:level]
  expect(src).to eq(level)
end

Then(/^the section should be (.+)$/) do |section|
  expect(@event[:section]).to eq(section)
end

Then(/^the( imported)? dances should be:$/) do |imported, table|
  src = if imported
          @imported_event.sub_events.map { |se| se.dance.name }
        else
          @event[:dances]
        end
  table.diff!(src.map { |d| [d] })
end

Then(/^(imported )?round ([0-9]+) should have the following judges:$/) do |imported, round, table|
  idx = round.to_i - 1
  src = if imported
          @imported_event.rounds[idx].adjudicators.map(&:shorthand)
        else
          @event[:rounds][idx][:judges]
        end
  table.diff!(src.map { |j| [j] })
end

Then(/^(imported )?round ([0-9]+) should( not)? be final$/) do |imported, round, not_final|
  idx = round.to_i - 1
  final = if imported
            @imported_event.rounds[idx].final
          else
            @event[:rounds][idx][:final]
          end
  expect(final).to (not_final ? be_false : be_true)
end

# Matches a given round number against a table with couple names. The table
# should have the following headers:
#
#     | number | lead name | lead team | follow name | follow team | no name |
Then(/^(imported )?round ([0-9]+) should have the following couples:$/) do |imported, round, table|
  idx = round.to_i - 1
  table.map_headers! { |h| h.parameterize.underscore.to_sym }
  table.map_column!('number', &:to_i)
  couples =
    if imported
      @imported_event.rounds[idx].couples.map do |c|
      {
        number: c.number,
        lead_name: c.lead.first_name + " " + c.lead.last_name,
        lead_team: c.lead.team.name,
        follow_name: c.follow.first_name + " " + c.follow.last_name,
        follow_team: c.follow.team.name
      }
    end
    else
      @event[:rounds][idx][:couples].map do |c|
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
Then(/^(imported )?round ([0-9]+) should have the following marks in the dance "(.+)":$/) do |imported, round, dance, table|
  table.map_column!('number', &:to_i)
  idx = round.to_i - 1
  if imported
    round = @imported_event.rounds[idx]
    judge_hash = Hash[round.adjudicators.map { |j| [j.shorthand, j] }]
    couples = round.couples
    sub_round = round.sub_rounds.detect { |sr| sr.dance.name == dance }
    actual = couples.map do |c|
      res = {"number" => c.number }
      judge_hash.each do |short, judge|
        mark = Mark.find_by(adjudicator: judge,
                            sub_round_id: sub_round.id,
                            couple: c)
        res[short] = if mark
                       (mark.placement == 0) ? 'X' : mark.placement.to_s
                     else
                       ''
                     end
      end
    end
  else
    couples = @event[:rounds][idx][:couples]
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

end

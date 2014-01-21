require 'results_scrapers'

# Parse `file` using `ResultsScrapers::<mod>.scrape_event`.
Given(/^I parse the event file "(.+)" with "(.+)"$/) do |file, mod|
  scrape_func = ResultsScrapers.const_get(mod.to_sym).method(:scrape_event)
  @event = scrape_func.call(Nokogiri::HTML(open(file)))
end

Given(/^I parse the competition file "(.+)" with "(.+)"$/) do |file, mod|
  scrape_func = ResultsScrapers.const_get(mod.to_sym).method(:scrape_comp)
  @comp = scrape_func.call(Nokogiri::HTML(open(file)))
end

Given(/^I import the competition file "(.+)" with "(.+)"$/) do |file, mod|
  step %Q{I parse the competition file "#{file}" with "#{mod}"}
  @imported_comp = ResultsScrapers::Importer.import_comp(@comp)
end

Given(/^I import the event file "(.+)" with "(.+)" using (\d+) judges$/) do |file, mod, num_judges|
  step %Q{I parse the event file "#{file}" with "#{mod}"}
  comp = @comp || FactoryGirl.create(:competition)
  FactoryGirl.create_list(:adjudicator, num_judges, competition: comp)
  @imported_event = ResultsScrapers::Importer.import_event(@event, comp)
end

Then(/^the( imported)? event should be number (\d+)$/) do |imported, num|
  src = if imported
          @imported_event.number
        else
          @event[:number]
        end
  expect(src).to eq(num)
end

Then(/^there should be (\d+) (imported )?rounds$/) do |num, imported|
  src = imported ? @imported_event.rounds : @event[:rounds]
  expect(@event[:rounds].length).to eq(num)
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

Then(/^(imported )?round (\d+) should have the following judges:$/) do |imported, round, table|
  idx = round - 1
  src = if imported
          @imported_event.rounds[idx].adjudicators.map(&:shorthand)
        else
          @event[:rounds][idx][:judges]
        end
  table.diff!(src.map { |j| [j] })
end

Then(/^(imported )?round (\d+) should( not)? be final$/) do |imported, round, not_final|
  idx = round - 1
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
Then(/^(imported )?round (\d+) should have the following couples:$/) do |imported, round, table|
  idx = round - 1
  table.map_headers! { |h| h.parameterize.underscore.to_sym }
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
Then(/^(imported )?round (\d+) should have the following marks in the dance "(.+)":$/) do |imported, round, dance, table|
  idx = round - 1
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

Then(/^the( imported)? competition should be called "(.+)"$/) do |imported, name|
  src = if imported
          @imported_comp.name
        else
          @comp[:name]
        end
  expect(src).to eq(name)
end

Then(/^the year should be (\d+)$/) do |year|
  expect(@comp[:year]).to eq(year)
end

Then(/^the( imported)? competition should have the following adjudicators:$/) do |imported, table|
  table.map_headers! { |h| h.parameterize.underscore.to_sym }
  src = if imported
          @imported_comp.adjudicators.map { |a| [a.shorthand,
                                                 a.first_name,
                                                 a.last_name] }
        else
          @comp[:judges]
        end
  table.diff!(src)
end

Then(/^the competition should have the following events:$/) do |table|
  table.map_headers! { |h| h.parameterize.underscore.to_sym }

  table.diff!(@comp[:events])
end

Transform(/^table:number/) do |table|
  table.map_column!(:number) {|num| num.to_i }
  table
end

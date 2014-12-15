require 'results_scrapers'

# Parse `file` using `ResultsScrapers::<mod>.scrape_event`.
Given(/^I fetch and parse event (\d+) from comp "(.+)" with "(.+)"$/) do |event, comp, mod_name|
  mod = ResultsScrapers.const_get(mod_name.to_sym)
  url = mod.method(:event_url).call(comp, event)
  stub = stub_request(:get, url).
    to_return(body: File.new(event_file_path(mod_name, comp, event)))

  scrape_func = mod.method(:fetch_and_scrape_event)
  @event = scrape_func.call(comp, event)
  expect(stub).to have_been_requested
end

Given(/^I fetch and parse the competition "(.+)" with "(.+)"$/) do |comp, mod_name|
  mod = ResultsScrapers.const_get(mod_name.to_sym)
  comp_stub = stub_comp_request(mod_name, comp)
  num_event_files = event_files_for(mod_name, comp).count
  event_stub = stub_event_requests(mod_name, comp, num_event_files)
  scrape_func = mod.method(:fetch_and_scrape_comp)

  @comp = scrape_func.call(comp)
  expect(comp_stub).to have_been_requested
  expect(event_stub).to have_been_requested.times(num_event_files)
end

Given(/^I fetch and import the competition "(.+)" with "(.+)"$/) do |comp, mod_name|
  mod = ResultsScrapers.const_get(mod_name.to_sym)
  step %Q{I fetch and parse the competition "#{comp}" with "#{mod_name}"}

  @imported_comp = ResultsScrapers::Importer.import_comp(@comp)
end

Given(/^I fetch and import event (\d+) from comp "(.+)" with "(.+)" using (\d+) judges$/) do |event, comp, mod_name, num_judges|
  step %Q{I fetch and parse event #{event} from comp "#{comp}" with "#{mod_name}"}
  comp = FactoryGirl.create(:competition)
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

Then(/^there should be (\d+) (imported )?rounds?$/) do |num, imported|
  src = imported ? @imported_event.rounds : @event[:rounds]
  expect(src.length).to eq(num)
end

Then(/^the( imported)? level should be (.+)$/) do |imported, level|
  src = imported ? @imported_event.level.name : @event[:level]
  expect(src).to eq(level)
end

Then(/^the section should be (.+)$/) do |section|
  expect(@event[:section]).to eq(section)
end

Then(/^the( imported)? dances? should be:$/) do |imported, table|
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
  expect(final).to be (not_final ? false : true)
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
    sub_round = round.sub_rounds.find { |sr| sr.dance.name == dance }
    actual = couples.map do |c|
      res = { 'number' => c.number }
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
      res = { 'number' => c[:number] }
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
          @imported_comp.adjudicators.map do |a|
      {
        shorthand: a.shorthand,
        first_name: a.user.first_name,
        last_name: a.user.last_name
      }
    end
        else
          @comp[:judges]
        end
  table.diff!(src)
end

Then(/^the( imported)? competition should have the following events?:$/) do |imported, table|
  table.map_headers! { |h| h.parameterize.underscore.to_sym }

  src = if imported
          @imported_comp.events.map do |event|
      {
        number: event.number,
        level: event.level.name,
        dances: event.dances.map(&:base_name).join(', ')
      }
    end
        else
          @comp[:events]
        end
  table.diff!(src)
end

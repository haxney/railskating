Given(/^a competition$/) do
  @comp ||= create(:competition)
end

# Creates a competition and events from a table. The table must be of the form:
#
#     | number | level    | dances                          |
#     |      1 | Newcomer | American Cha Cha                |
#     |      2 | Newcomer | American Rumba                  |
#     |      3 | Newcomer | American Swing                  |
#     |      4 | Bronze   | American Cha Cha/American Rumba |
Given(/^a competition with the following events:$/) do |table|
  step 'a competition'

  table.map_headers! { |h| h.parameterize.underscore.to_sym }
  @table = table.dup # Need to duplicate, otherwise bad things happen.
  table.hashes.each do |row|

    event = create(:event,
                   competition: @comp,
                   number: row[:number],
                   level: Level.find_by!(name: row[:level]))
    row[:dances].split('/').each do |d|
      dance = Dance.find_by!(name: d)
      create(:sub_event, event: event, dance: dance)
    end
  end
end

When(/^I visit the competition page$/) do
  visit(competition_path(@comp))
end

Then(/^there should be no events$/) do
  expect(all('ol.events_list li')).to be_empty
end

# Checks that the competition overview page generated a list of events.
#
# Reuses an existing `@table` from an earlier `Given a competition with the
# following events:` step.
When(/^I should see links to the events$/) do
  actual = all('ol.events_list li').map do |row|
    md = /Event #(\d+): (.+?) (.+)/.match(row.text)
    {
      number: md[1].to_i,
      level: Level.find_by!(name: md[2]).name,
      dances: md[3]
    }
  end

  @table.diff!(actual)
end

# Step definitions for scores

Given(/^the adjudicators marked the following couples (?:for|in) #{capture_model}$/) do |sub_round_str, table|
  sub_round = model!(sub_round_str)
  sub_event = sub_round.sub_event
  event = sub_event.event
  competition = event.competition

  # Remap the headers so that all the columns (aside from the first, the
  # "couple" column) are instances of the `Adjudicator` model (created by a
  # factory).
  table.map_headers! do |header|
    if header == 'couple'
      header
    else
      find_or_create_model("adjudicator",
                           header,
                           competition: competition,
                           shorthand: header)
    end
  end

  # Create the couple and assign them marks for the sub round.
  table.hashes.each do |row|
    label = row.delete('couple')
    couple = find_or_create_model('couple',
                                  label,
                                  event: event,
                                  number: label.to_i)

    # Each adjudicator's mark (or lack thereof) for the current couple
    row.each do |judge, place|
      place = '0' if place == 'X'

      # Only create the mark if the entry in the table is not ' '.
      create_model('mark',
                   adjudicator: judge,
                   couple: couple,
                   sub_round: sub_round,
                   placement: place.to_i) if /\w+/ =~ place
    end
  end
end

# Find or create a model with the given fields.
#
# Since there could be multiple sub rounds within a single round, don't recreate
# the couples or adjudicators in each table.
def find_or_create_model(factory, label, fields)
  name = "#{factory} \"#{label}\""
  find_model(name, fields) or create_model(name, fields)
end

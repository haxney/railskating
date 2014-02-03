module EventsHelper

  # Creates a title for the event by combining the `event` number, level, and
  # dance names.
  def build_event_title(event)
    res = "Event ##{event.number}: #{event.level.name} "
    res << event.sub_events.map { |se| se.dance.name }.join('/')
  end

  # Creates the list of classes for the event summary table.
  def event_summary_table_classes
    ['results_round',
     'results_event',
     'final_summary']
  end

  # Creates the id for the event summary table.
  def event_summary_table_id
    'results_event'
  end
end

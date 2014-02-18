module EventsHelper

  # Creates a title for the event by combining the `event` number, level, and
  # dance names.
  def build_event_title(event)
    dances = event.sub_events.map { |se| se.dance.name }.join('/')
    t('events.title',
      number: event.number,
      level: event.level.name,
      dances: dances)
  end

  # Creates the list of classes for the event summary table.
  def event_summary_table_classes
    ['results_round',
     'results_event',
     'final_summary']
  end

  # Creates the id for the event summary table.
  def event_summary_table_id
    'final_summary'
  end
end

module EventsHelper

  def build_title(event)
    res = "Event ##{event.number}: #{event.level.name} "
    res << event.sub_events.map { |se| se.dance.name }.join('/')
  end
end

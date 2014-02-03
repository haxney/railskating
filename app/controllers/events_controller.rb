class EventsController < ApplicationController
  # GET /competitions/:competition_id/events/:number
  def show
    @event = Event.includes(rounds: [:adjudicators, { sub_rounds: :dance},
                              {couples: [:lead, :follow]}])
      .find_by(competition_id: params[:competition_id],
               number: params[:number])

    @event.compute_placements if @event.final_round
  end
end

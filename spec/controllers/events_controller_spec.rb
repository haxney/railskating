require 'rails_helper'

describe EventsController, type: :controller do
  describe "GET show" do
    it "assigns the requested event as @event" do
      event = create(:event)
      get :show, competition_id: event.competition.id.to_s,
        number: event.number.to_s
      expect(assigns(:event)).to eq(event)
    end
  end
end

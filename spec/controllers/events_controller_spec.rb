require 'spec_helper'

describe EventsController do
  describe "GET show" do
    it "assigns the requested event as @event" do
      event = create(:event)
      get :show, competition_id: event.competition.id.to_s,
        number: event.number.to_s
      assigns(:event).should eq(event)
    end
  end
end

require "spec_helper"

describe EventsController, type: :routing do
  describe "routing" do
    it "routes to #show" do
      get('/competitions/1/events/2').should route_to('events#show',
                                                      competition_id: '1',
                                                      number: '2')
    end
  end
end

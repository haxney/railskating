require 'spec_helper'

describe CompetitionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get('/competitions')).to route_to('competitions#index')
    end

    it "routes to #show" do
      expect(get('/competitions/1')).to route_to('competitions#show', id: '1')
    end

  end
end

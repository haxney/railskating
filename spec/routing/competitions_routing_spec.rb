require 'spec_helper'

describe CompetitionsController do
  describe "routing" do

    it "routes to #index" do
      get('/competitions').should route_to('competitions#index')
    end

    it "routes to #show" do
      get('/competitions/1').should route_to('competitions#show', id: '1')
    end

  end
end

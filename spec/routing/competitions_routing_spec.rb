require "spec_helper"

describe CompetitionsController do
  describe "routing" do

    it "routes to #index" do
      get("/competitions").should route_to("competitions#index")
    end

    it "routes to #new" do
      get("/competitions/new").should route_to("competitions#new")
    end

    it "routes to #show" do
      get("/competitions/1").should route_to("competitions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/competitions/1/edit").should route_to("competitions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/competitions").should route_to("competitions#create")
    end

    it "routes to #update" do
      put("/competitions/1").should route_to("competitions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/competitions/1").should route_to("competitions#destroy", :id => "1")
    end

  end
end

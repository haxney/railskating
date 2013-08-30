require "spec_helper"

describe LevelsController do
  describe "routing" do

    it "routes to #index" do
      get("/levels").should route_to("levels#index")
    end

    it "routes to #new" do
      get("/levels/new").should route_to("levels#new")
    end

    it "routes to #show" do
      get("/levels/1").should route_to("levels#show", :id => "1")
    end

    it "routes to #edit" do
      get("/levels/1/edit").should route_to("levels#edit", :id => "1")
    end

    it "routes to #create" do
      post("/levels").should route_to("levels#create")
    end

    it "routes to #update" do
      put("/levels/1").should route_to("levels#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/levels/1").should route_to("levels#destroy", :id => "1")
    end

  end
end

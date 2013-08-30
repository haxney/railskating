require "spec_helper"

describe DancesController do
  describe "routing" do

    it "routes to #index" do
      get("/dances").should route_to("dances#index")
    end

    it "routes to #new" do
      get("/dances/new").should route_to("dances#new")
    end

    it "routes to #show" do
      get("/dances/1").should route_to("dances#show", :id => "1")
    end

    it "routes to #edit" do
      get("/dances/1/edit").should route_to("dances#edit", :id => "1")
    end

    it "routes to #create" do
      post("/dances").should route_to("dances#create")
    end

    it "routes to #update" do
      put("/dances/1").should route_to("dances#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/dances/1").should route_to("dances#destroy", :id => "1")
    end

  end
end

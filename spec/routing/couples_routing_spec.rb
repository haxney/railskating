require "spec_helper"

describe CouplesController do
  describe "routing" do

    it "routes to #index" do
      get("/couples").should route_to("couples#index")
    end

    it "routes to #new" do
      get("/couples/new").should route_to("couples#new")
    end

    it "routes to #show" do
      get("/couples/1").should route_to("couples#show", :id => "1")
    end

    it "routes to #edit" do
      get("/couples/1/edit").should route_to("couples#edit", :id => "1")
    end

    it "routes to #create" do
      post("/couples").should route_to("couples#create")
    end

    it "routes to #update" do
      put("/couples/1").should route_to("couples#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/couples/1").should route_to("couples#destroy", :id => "1")
    end

  end
end

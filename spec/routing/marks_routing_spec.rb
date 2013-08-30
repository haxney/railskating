require "spec_helper"

describe MarksController do
  describe "routing" do

    it "routes to #index" do
      get("/marks").should route_to("marks#index")
    end

    it "routes to #new" do
      get("/marks/new").should route_to("marks#new")
    end

    it "routes to #show" do
      get("/marks/1").should route_to("marks#show", :id => "1")
    end

    it "routes to #edit" do
      get("/marks/1/edit").should route_to("marks#edit", :id => "1")
    end

    it "routes to #create" do
      post("/marks").should route_to("marks#create")
    end

    it "routes to #update" do
      put("/marks/1").should route_to("marks#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/marks/1").should route_to("marks#destroy", :id => "1")
    end

  end
end

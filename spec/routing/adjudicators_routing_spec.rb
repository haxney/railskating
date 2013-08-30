require "spec_helper"

describe AdjudicatorsController do
  describe "routing" do

    it "routes to #index" do
      get("/adjudicators").should route_to("adjudicators#index")
    end

    it "routes to #new" do
      get("/adjudicators/new").should route_to("adjudicators#new")
    end

    it "routes to #show" do
      get("/adjudicators/1").should route_to("adjudicators#show", :id => "1")
    end

    it "routes to #edit" do
      get("/adjudicators/1/edit").should route_to("adjudicators#edit", :id => "1")
    end

    it "routes to #create" do
      post("/adjudicators").should route_to("adjudicators#create")
    end

    it "routes to #update" do
      put("/adjudicators/1").should route_to("adjudicators#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/adjudicators/1").should route_to("adjudicators#destroy", :id => "1")
    end

  end
end

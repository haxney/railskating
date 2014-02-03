require 'spec_helper'

describe CompetitionsController do
  describe "GET index" do
    it "assigns all competitions as @competitions" do
      competition = create(:competition)
      get :index
      assigns(:competitions).should eq([competition])
    end
  end

  describe "GET show" do
    it "assigns the requested competition as @competition" do
      competition = create(:competition)
      get :show, id: competition.id.to_s
      assigns(:competition).should eq(competition)
    end
  end
end

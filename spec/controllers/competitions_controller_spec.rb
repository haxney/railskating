require 'rails_helper'

describe CompetitionsController, type: :controller do
  describe "GET index" do
    it "assigns all competitions as @competitions" do
      competition = create(:competition)
      get :index
      expect(assigns(:competitions)).to eq([competition])
    end
  end

  describe "GET show" do
    it "assigns the requested competition as @competition" do
      competition = create(:competition)
      get :show, id: competition.id.to_s
      expect(assigns(:competition)).to eq(competition)
    end
  end
end

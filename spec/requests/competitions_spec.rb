require 'spec_helper'

describe "Competitions", type: :request do
  describe "GET /competitions" do
    it "works! (now write some real specs)" do
      get competitions_path
      expect(response.status).to be(200)
    end
  end
end

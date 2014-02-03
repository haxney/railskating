require 'spec_helper'

describe "Competitions" do
  describe "GET /competitions" do
    it "works! (now write some real specs)" do
      get competitions_path
      response.status.should be(200)
    end
  end
end

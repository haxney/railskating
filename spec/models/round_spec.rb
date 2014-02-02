require 'spec_helper'

describe Round do
  context 'factory' do
    let(:event) { create(:event) }

    it "should not create duplicate rounds when given a number" do
      r1 = create(:round, event: event, number: 1)
      r2 = create(:round, event: event, number: 1)
      expect(r1).to eq(r2)
    end

    it "should create duplicate rounds without an explicit number" do
      r1 = create(:round, event: event)
      r2 = create(:round, event: event)
      expect(r1.number).not_to eq(r2.number)
    end
  end
end

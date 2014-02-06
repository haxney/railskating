require 'spec_helper'

describe Couple do
  let(:couple) { create(:couple) }
  describe '#lead' do
    before(:each) { @lead = couple.lead }
    it "does not destroy associated lead" do
      couple.destroy
      expect(@lead.destroyed?).to be_false
    end
  end

  describe '#follow' do
    before(:each) { @follow = couple.follow }
    it "does not destroy associated follow" do
      couple.destroy
      expect(@follow.destroyed?).to be_false
    end
  end

  describe '#placement_in' do
    it "should return the placement for a Round" do
      round = create(:round)
      placement = Placement.create(couple: couple, event: round.event)

      expect(couple.placement_in(round)).to eq(placement)
    end

    it "should raise an error when the couple does not have a placement" do
      round = create(:round)
      expect { couple.placement_in(round) }.to raise_error
    end

    it "should raise an error when given an invalid grouping" do
      expect { couple.placement_in(5) }.to raise_error
    end
  end
end

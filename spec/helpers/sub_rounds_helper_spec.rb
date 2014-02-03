require 'spec_helper'

describe SubRoundsHelper do
  describe "#sub_round_table_classes" do
    it "should return the correct classes for a SubRound" do
      dance = Constants::Dances::AMERICAN_WALTZ
      se = create(:sub_event, dance: dance)
      sr = create(:sub_round, sub_event: se)
      classes = helper.sub_round_table_classes(sr)

      expect(classes).to eq(%w{results_sub_round_final
                               results_round
                               dance_american_waltz})
    end
  end

  describe "#sub_round_table_id" do
    it "should return the table ID" do
      sr = create(:sub_round)
      num = sr.round.number
      weight = sr.sub_event.weight
      id = helper.sub_round_table_id(sr)
      expect(id).to eq("results_sub_round_#{num}_#{weight}")
    end
  end

  describe '#cumulative_placement_header' do

    it "should return 1 for input 1" do
      expect(helper.cumulative_placement_header(1)).to eq('1')
    end

    it "should return a range for other arguments" do
      expect(helper.cumulative_placement_header(2)).to eq('1–2')
      expect(helper.cumulative_placement_header(3)).to eq('1–3')
    end
  end
end

require 'spec_helper'

describe RoundsHelper do
  describe '#round_table_classes' do
    it "should create classes for a non-final round" do
      res = helper.round_table_classes(build_stubbed(:round, final: false))
      expect(res).to eq(%w{results_round results_round_prelim})
    end

    it "should create classes for a final round" do
      res = helper.round_table_classes(build_stubbed(:round, final: true))
      expect(res).to eq(%w{results_round results_round_final})
    end
  end

  describe '#round_table_id' do
    it "should build a table id" do
      res = helper.round_table_id(build_stubbed(:round, number: 1))
      expect(res).to eq('results_round_1')
    end
  end

  describe '#round_header_colspan' do
    it "should count the number of adjudicators" do
      round = build_stubbed(:round)
      comp = build_stubbed(:competition)
      round.adjudicators = build_list(:adjudicator, 4, competition: comp)
      res = helper.round_header_colspan(round)
      expect(res).to eq(4)
    end
  end
end

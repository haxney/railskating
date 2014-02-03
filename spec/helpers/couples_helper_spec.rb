require 'spec_helper'

describe CouplesHelper do
  before(:all) do
    @comp = create(:competition)
    @judge = create(:adjudicator, competition: @comp, shorthand: 'A')
    @event = create(:event, competition: @comp)
    @couple = create(:couple, event: @event)
    @dance = Constants::Dances::AMERICAN_WALTZ
    @sub_event = create(:sub_event, event: @event, dance: @dance)
    @round = create(:round, event: @event)
    @sub_round = create(:sub_round, round: @round, sub_event: @sub_event)
  end

  after(:all) do
    @comp.destroy
  end

  describe '#format_cell' do
    # Lazily created
    let(:res) { helper.format_cell(@couple,
                                   @sub_round,
                                   @judge) }
    let(:xml) { Nokogiri::XML(res) }

    it "should create an empty cell with no Mark" do
      expect(xml.root.name).to eq('span')
      expect(xml.root['class']).to eq('hidden')
      expect(xml.text).to include('No mark')
    end

    it "should create a check mark for a prelim-round Mark" do
      create(:mark,
             adjudicator: @judge,
             sub_round: @sub_round,
             couple: @couple,
             placement: 0)

      expect(res).to include('Mark')
      expect(xml.root.name).to eq('i')
      expect(xml.root['class']).to eq('fa fa-check')
    end

    it "should return the placement number for a final-round Mark" do
      create(:mark,
             adjudicator: @judge,
             sub_round: @sub_round,
             couple: @couple,
             placement: 1)
      expect(res).to eq('1')
    end
  end

  describe '#mark_cell_classes' do
    it "should return the correct classes" do
      res = helper.mark_cell_classes(@sub_round, @judge)

      expect(res).to eq(%w{mark_cell data_cell
                           dance_american_waltz
                           adjudicator_col
                           adjudicator_A_col})
    end
  end

  describe '#result_cell_classes' do
    it "should return the correct classes" do
      res = helper.result_cell_classes(@round)

      expect(res).to eq(%w{result_cell
                           data_cell
                           recalled_col})
    end
  end

  describe '#cumulative_cell_classes' do
    it "should return the correct classes" do
      res = helper.cumulative_cell_classes(1)
      expect(res).to eq(%w{data_cell
                           cumulative_cell
                           cumulative_cell_1})
    end
  end

  describe '#placement_cell_classes' do
    it "should return classes for a SubRound" do
      res = helper.placement_cell_classes(Constants::Dances::AMERICAN_WALTZ)

      expect(res).to eq(%w{sub_placement_col
                           sub_placement_cell
                           data_cell
                           dance_american_waltz})
    end

    it "should return classes for a final summary" do
      res = helper.placement_cell_classes

      expect(res).to eq(%w{placement_col
                           placement_cell
                           data_cell})
    end
  end

  describe '#rule_cell_classes' do
    it "should include classes for a non-rule placement" do
      place = build_stubbed(:placement, rule: nil)
      res = helper.rule_cell_classes(place)
      expect(res).to eq(%w{rule_col})
    end

    it "should include a class when the placement is rule 10" do
      place = build_stubbed(:placement, rule: 10)
      res = helper.rule_cell_classes(place)
      expect(res).to eq(%w{rule_col rule_col_10})
    end

    it "should include a class when the placement is rule 11" do
      place = build_stubbed(:placement, rule: 11)
      res = helper.rule_cell_classes(place)
      expect(res).to eq(%w{rule_col rule_col_11})
    end
  end

  describe '#format_rule_cell' do
    it "should be empty for a non-rule placement" do
      place = build_stubbed(:placement, rule: nil)
      res = helper.format_rule_cell(place)
      expect(res).to be_empty
    end

    it "should be 'R10' when the placement is rule 10" do
      place = build_stubbed(:placement, rule: 10)
      res = helper.format_rule_cell(place)
      expect(res).to eq("R10")
    end

    it "should be 'R11' when the placement is rule 11" do
      place = build_stubbed(:placement, rule: 11)
      res = helper.format_rule_cell(place)
      expect(res).to eq("R11")
    end
  end
end

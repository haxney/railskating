require 'spec_helper'

describe AdjudicatorsHelper do
  describe '#adjudicator_header_classes' do
    it "creates a list of classes" do
      ad = create(:adjudicator, shorthand: 'A')
      dance = Constants::Dances::AMERICAN_WALTZ
      se = create(:sub_event, dance: dance)
      sr = create(:sub_round, sub_event: se)
      classes = helper.adjudicator_header_classes(ad, sr)

      expect(classes).to eq(%w{adjudicator_col adjudicator_A_col dance_american_waltz})
    end
  end
end

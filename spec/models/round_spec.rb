require 'spec_helper'

describe Round do
  describe "#recall" do
    let(:competition) { create(:competition) }
    let(:event) { create(:event, competition: competition) }
    let(:sub_event) { create(:sub_event, event: event) }
    let(:round) { create(:round, event: event, requested: 6) }
    let(:sub_round) { create(:sub_round, round: round, sub_event: sub_event) }
    let(:couples) { create_list(:random_couple, 10, event: event) }
    let(:adjudicators) { create_list(:random_adjudicator, 7, competition: competition) }

    context "when unambiguous" do

    end
  end

end

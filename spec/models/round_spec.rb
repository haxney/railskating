require 'spec_helper'

describe Round do
  describe "#recall" do
    let(:competition) { FactoryGirl.create(:competition) }
    let(:event) { FactoryGirl.create(:event, competition: competition) }
    let(:sub_event) { FactoryGirl.create(:sub_event, event: event) }
    let(:round) { FactoryGirl.create(:round, event: event, requested: 6) }
    let(:sub_round) { FactoryGirl.create(:sub_round, round: round, sub_event: sub_event) }
    let(:couples) { FactoryGirl.create_list(:random_couple, 10, event: event) }
    let(:adjudicators) { FactoryGirl.create_list(:random_adjudicator, 7, competition: competition) }

    context "when unambiguous" do

    end
  end

end

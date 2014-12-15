require 'rails_helper'

describe Event do
  let(:event) { create(:event) }
  describe '#couples' do

    it "destroys associated Couples" do
      create_list(:couple, 2, event: event)
      expect { event.destroy }.not_to raise_error
      expect(Couple.where(event_id: event.id).count).to eq(0)
    end
  end

  describe '#sub_events' do

    it "destroys associated SubEvents" do
      @sub_event = create(:sub_event, event: event)
      expect { event.destroy }.not_to raise_error
      expect(SubEvent.where(event_id: event.id).count).to eq(0)
      expect { @sub_event.reload }.to raise_error
    end

    it "finds SubEvents in order" do
      se2 = create(:sub_event, event: event,
                   dance: Constants::Dances::AMERICAN_CHA_CHA, weight: 2)
      se1 = create(:sub_event, event: event,
                   dance: Constants::Dances::AMERICAN_MAMBO, weight: 1)
      se3 = create(:sub_event, event: event,
                   dance: Constants::Dances::AMERICAN_RUMBA, weight: 3)
      sub_events = [se1, se2, se3]
      expect(event.sub_events.count).to eq(3)
      expect(event.sub_events).to eq(sub_events)
    end
  end
end

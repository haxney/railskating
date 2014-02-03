require 'spec_helper'

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
  end
end

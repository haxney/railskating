require 'spec_helper'

describe Event do
  subject { FactoryGirl.create(:event) }
  describe '#couples' do
    before(:each) { FactoryGirl.create_list(:couple, 2, event: subject) }

    it "destroys associated Couples" do
      expect { subject.destroy }.not_to raise_error
      expect(Couple.count).to eq(0)
    end
  end

  describe '#sub_events' do
    before(:each) { @sub_event = FactoryGirl.create(:sub_event, event: subject) }

    it "destroys associated SubEvents" do
      expect { subject.destroy }.not_to raise_error
      expect(SubEvent.count).to eq(0)
      expect { @sub_event.reload }.to raise_error
    end
  end
end

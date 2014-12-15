require 'rails_helper'

describe Competition do
  subject { FactoryGirl.create(:competition) }
  describe '#events' do
    before(:each) { FactoryGirl.create_list(:event, 2, competition: subject) }

    it "destroys associated events" do
      expect { subject.destroy }.not_to raise_error
      expect(Event.count).to eq(0)
    end
  end

  describe '#adjudicators' do
    before(:each) { FactoryGirl.create_list(:adjudicator, 2, competition: subject) }

    it "destroys associated Adjudicators" do
      expect { subject.destroy }.not_to raise_error
      expect(Adjudicator.count).to eq(0)
    end
  end

  describe 'sub_events' do
    before(:each) do
      event = FactoryGirl.create(:event, competition: subject)
      @sub_event = FactoryGirl.create(:sub_event, event: event)
    end

    it "destroys associated SubEvents" do
      expect { subject.destroy }.not_to raise_error
      expect(SubEvent.count).to eq(0)
      expect { @sub_event.reload }.to raise_error
    end
  end

  describe 'marks' do
    before(:each) do
      event = FactoryGirl.create(:event, competition: subject)
      sub_event = FactoryGirl.create(:sub_event, event: event)
      sub_round = FactoryGirl.create(:sub_round, sub_event: sub_event)
      @mark = FactoryGirl.create(:mark, sub_round: sub_round)
    end

    it "destroys associated Marks" do
      expect { subject.destroy }.not_to raise_error
      expect(Mark.count).to eq(0)
      expect { @mark.reload }.to raise_error
    end
  end
end

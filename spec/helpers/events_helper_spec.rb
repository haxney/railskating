require 'spec_helper'

describe EventsHelper, type: :helper do
  let(:event) { create(:event,
                        level: Constants::Levels::SILVER,
                        number: 1) }

  describe '#build_event_title' do
    let(:res) { helper.build_event_title(event) }
    it "should build an event title for a single-dance event" do
      create(:sub_event, event: event, dance: Constants::Dances::AMERICAN_WALTZ)
      expect(res).to eq("Event #1: Silver American Waltz")
    end

    it "should build an event title for a multi-dance event" do
      create(:sub_event, event: event, dance: Constants::Dances::AMERICAN_WALTZ)
      create(:sub_event, event: event, dance: Constants::Dances::AMERICAN_FOXTROT)
      expect(res).to eq("Event #1: Silver American Waltz/American Foxtrot")
    end
  end

  describe '#event_summary_table_classes' do
    it "should build the list of classes" do
      res = helper.event_summary_table_classes
      expect(res).to eq(%w{results_round results_event final_summary})
    end
  end

  describe '#event_summary_table_id' do

    it "should return the table id" do
      expect(helper.event_summary_table_id).to eq('final_summary')
    end
  end
end

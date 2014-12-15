require 'rails_helper'

describe Adjudicator do
  describe '#marks' do
    subject { FactoryGirl.create(:adjudicator) }
    before(:each) { FactoryGirl.create_list(:mark, 2, adjudicator: subject) }

    it "allows destruction with no Marks" do
      subject.marks.each(&:destroy)
      expect { subject.reload.destroy }.not_to raise_error
    end
  end
end

require 'spec_helper'

describe Couple do
  subject { FactoryGirl.create(:couple) }
  describe '#lead' do
    before(:each) { @lead = subject.lead }
    it "does not destroy associated lead" do
      subject.destroy
      expect(@lead.destroyed?).to be_false
    end
  end

  describe '#follow' do
    before(:each) { @follow = subject.follow }
    it "does not destroy associated follow" do
      subject.destroy
      expect(@follow.destroyed?).to be_false
    end
  end
end

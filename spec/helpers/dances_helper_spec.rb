require 'spec_helper'

describe DancesHelper do
  describe '#dance_to_class_name' do
    it "should format the name of a dance" do
      res = helper.dance_to_class_name(Constants::Dances::AMERICAN_WALTZ)
      expect(res).to eq('dance_american_waltz')
    end
  end
end

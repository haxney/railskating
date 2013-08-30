require 'spec_helper'

describe "rounds/index.html.haml" do
  before(:each) do
    assign(:rounds, [
      stub_model(Round,
        :event_id => 1,
        :number => 1,
        :final => false,
        :requested => 1,
        :cutoff => 1
      ),
      stub_model(Round,
        :event_id => 1,
        :number => 1,
        :final => false,
        :requested => 1,
        :cutoff => 1
      )
    ])
  end

  it "renders a list of rounds" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end

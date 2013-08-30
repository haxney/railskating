require 'spec_helper'

describe "marks/index.html.haml" do
  before(:each) do
    assign(:marks, [
      stub_model(Mark,
        :adjudicator_id => 1,
        :round_id => 1,
        :couple_id => 1,
        :placement => 1
      ),
      stub_model(Mark,
        :adjudicator_id => 1,
        :round_id => 1,
        :couple_id => 1,
        :placement => 1
      )
    ])
  end

  it "renders a list of marks" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end

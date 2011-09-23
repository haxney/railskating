require 'spec_helper'

describe "couples/index.html.haml" do
  before(:each) do
    assign(:couples, [
      stub_model(Couple,
        :lead_id => 1,
        :follow_id => 1,
        :event_id => 1,
        :number => 1
      ),
      stub_model(Couple,
        :lead_id => 1,
        :follow_id => 1,
        :event_id => 1,
        :number => 1
      )
    ])
  end

  it "renders a list of couples" do
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

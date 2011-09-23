require 'spec_helper'

describe "adjudicators/index.html.haml" do
  before(:each) do
    assign(:adjudicators, [
      stub_model(Adjudicator,
        :user_id => 1,
        :competition_id => 1,
        :shorthand => "Shorthand"
      ),
      stub_model(Adjudicator,
        :user_id => 1,
        :competition_id => 1,
        :shorthand => "Shorthand"
      )
    ])
  end

  it "renders a list of adjudicators" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Shorthand".to_s, :count => 2
  end
end

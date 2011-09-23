require 'spec_helper'

describe "rounds/edit.html.haml" do
  before(:each) do
    @round = assign(:round, stub_model(Round,
      :event_id => 1,
      :number => 1,
      :final => false,
      :requested => 1,
      :cutoff => 1
    ))
  end

  it "renders the edit round form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => rounds_path(@round), :method => "post" do
      assert_select "input#round_event_id", :name => "round[event_id]"
      assert_select "input#round_number", :name => "round[number]"
      assert_select "input#round_final", :name => "round[final]"
      assert_select "input#round_requested", :name => "round[requested]"
      assert_select "input#round_cutoff", :name => "round[cutoff]"
    end
  end
end

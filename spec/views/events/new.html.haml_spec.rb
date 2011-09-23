require 'spec_helper'

describe "events/new.html.haml" do
  before(:each) do
    assign(:event, stub_model(Event,
      :competition_id => 1,
      :level_id => 1,
      :number => 1
    ).as_new_record)
  end

  it "renders new event form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => events_path, :method => "post" do
      assert_select "input#event_competition_id", :name => "event[competition_id]"
      assert_select "input#event_level_id", :name => "event[level_id]"
      assert_select "input#event_number", :name => "event[number]"
    end
  end
end

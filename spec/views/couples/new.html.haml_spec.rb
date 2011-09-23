require 'spec_helper'

describe "couples/new.html.haml" do
  before(:each) do
    assign(:couple, stub_model(Couple,
      :lead_id => 1,
      :follow_id => 1,
      :event_id => 1,
      :number => 1
    ).as_new_record)
  end

  it "renders new couple form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => couples_path, :method => "post" do
      assert_select "input#couple_lead_id", :name => "couple[lead_id]"
      assert_select "input#couple_follow_id", :name => "couple[follow_id]"
      assert_select "input#couple_event_id", :name => "couple[event_id]"
      assert_select "input#couple_number", :name => "couple[number]"
    end
  end
end

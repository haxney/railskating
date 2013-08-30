require 'spec_helper'

describe "couples/show.html.haml" do
  before(:each) do
    @couple = assign(:couple, stub_model(Couple,
      :lead_id => 1,
      :follow_id => 1,
      :event_id => 1,
      :number => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end

require 'rails_helper'

describe "events/show.html.haml", type: :view do
  before(:each) do
    @event = assign(:event, stub_model(Event,
      :competition_id => 1,
      :level_id => 1,
      :number => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/1/)
  end
end

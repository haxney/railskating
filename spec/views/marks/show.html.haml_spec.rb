require 'spec_helper'

describe "marks/show.html.haml" do
  before(:each) do
    @mark = assign(:mark, stub_model(Mark,
      :adjudicator_id => 1,
      :round_id => 1,
      :couple_id => 1,
      :placement => 1
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

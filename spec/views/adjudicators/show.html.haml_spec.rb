require 'spec_helper'

describe "adjudicators/show.html.haml" do
  before(:each) do
    @adjudicator = assign(:adjudicator, stub_model(Adjudicator,
      :user_id => 1,
      :competition_id => 1,
      :shorthand => "Shorthand"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Shorthand/)
  end
end

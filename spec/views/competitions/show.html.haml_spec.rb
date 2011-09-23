require 'spec_helper'

describe "competitions/show.html.haml" do
  before(:each) do
    @competition = assign(:competition, stub_model(Competition,
      :name => "Name",
      :team_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end

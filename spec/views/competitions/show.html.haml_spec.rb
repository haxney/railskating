require 'spec_helper'

describe "competitions/show.html.haml", type: :view do
  before(:each) do
    @competition = assign(:competition, stub_model(Competition,
      :name => "Name",
      :team_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/1/)
  end
end

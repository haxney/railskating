require 'spec_helper'

describe "dances/show.html.haml" do
  before(:each) do
    @dance = assign(:dance, stub_model(Dance,
      :name => "Name",
      :section_id => 1
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

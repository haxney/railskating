require 'spec_helper'

describe "sections/show.html.haml" do
  before(:each) do
    @section = assign(:section, stub_model(Section,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end

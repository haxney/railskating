require 'spec_helper'

describe "levels/show.html.haml" do
  before(:each) do
    @level = assign(:level, stub_model(Level,
      :name => "Name",
      :weight => 1
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

require 'spec_helper'

describe "sections/edit.html.haml" do
  before(:each) do
    @section = assign(:section, stub_model(Section,
      :name => "MyString"
    ))
  end

  it "renders the edit section form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => sections_path(@section), :method => "post" do
      assert_select "input#section_name", :name => "section[name]"
    end
  end
end

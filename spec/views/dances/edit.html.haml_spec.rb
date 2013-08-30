require 'spec_helper'

describe "dances/edit.html.haml" do
  before(:each) do
    @dance = assign(:dance, stub_model(Dance,
      :name => "MyString",
      :section_id => 1
    ))
  end

  it "renders the edit dance form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => dances_path(@dance), :method => "post" do
      assert_select "input#dance_name", :name => "dance[name]"
      assert_select "input#dance_section_id", :name => "dance[section_id]"
    end
  end
end

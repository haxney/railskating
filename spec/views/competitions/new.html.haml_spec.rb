require 'spec_helper'

describe "competitions/new.html.haml" do
  before(:each) do
    assign(:competition, stub_model(Competition,
      :name => "MyString",
      :team_id => 1
    ).as_new_record)
  end

  it "renders new competition form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => competitions_path, :method => "post" do
      assert_select "input#competition_name", :name => "competition[name]"
      assert_select "input#competition_team_id", :name => "competition[team_id]"
    end
  end
end

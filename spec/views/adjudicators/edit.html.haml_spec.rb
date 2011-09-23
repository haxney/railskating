require 'spec_helper'

describe "adjudicators/edit.html.haml" do
  before(:each) do
    @adjudicator = assign(:adjudicator, stub_model(Adjudicator,
      :user_id => 1,
      :competition_id => 1,
      :shorthand => "MyString"
    ))
  end

  it "renders the edit adjudicator form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => adjudicators_path(@adjudicator), :method => "post" do
      assert_select "input#adjudicator_user_id", :name => "adjudicator[user_id]"
      assert_select "input#adjudicator_competition_id", :name => "adjudicator[competition_id]"
      assert_select "input#adjudicator_shorthand", :name => "adjudicator[shorthand]"
    end
  end
end
